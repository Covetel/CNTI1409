package CNTI1409::Controller::Usuarios;
use Moose;
use namespace::autoclean;
use Digest::MD5 qw(md5 md5_hex md5_base64);

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Usuarios - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	use Data::Dumper;
	my $usuario = $c->model('LDAP')->search(
		base => $c->config->{base_usuarios},
		filter => "(&(objectClass=posixAccount)(uid=wvargas))"
	)->shift_entry;

	my @r = $usuario->roles();

	if ($usuario->is_administrador){
		$c->log->debug("Es administrador");
	}

	if ($usuario->is_auditorJefe){
		$c->log->debug("Es Auditor Jefe");
	}


	my $u = $c->model('LDAP')->usuario("lramirez");
	$c->log->debug(Dumper($u));

	$c->response->body($u);

}

=head2 eliminar

Elimina usuarios del LDAP.

=cut 

sub eliminar : Local {
	my ( $self, $c ) = @_;
	my $u = $c->model('LDAP')->usuario($c->user->username);
	$c->assert_any_user_role(qw/AuditorJefe Administrador/);
	$c->stash->{template} = 'usuarios/eliminar.tt2';
	my $uid = $c->req->params->{uid};
	$c->stash->{uid} = $uid;
	
	# Este sistema no permite suicidios.
	if ($c->user->username ne $uid){
		# Busco el usuario en el LDAP. 
		my $usuario = $c->model('LDAP')->usuario($uid);
		if ($usuario) {
			if ($c->check_any_user_role("Administrador")){
				my $mesg = $usuario->delete();	
				if ($mesg->done()){
					$c->stash->{mensaje} = "El usuario $uid ha sido eliminado";
				} else {
					$c->stash->{error} = 1;
					$c->stash->{mensaje} = $mesg->error_text();
				}
			} elsif ($c->check_any_user_role("AuditorJefe")){
				if ($usuario->is_administrador){
					$c->stash->{error} = 1;
					$c->stash->{mensaje} = "Operación no permitida";
					utf8::decode($c->stash->{mensaje});
					$c->detach( 'CNTI1409::View::VistaPrincipal'); 
				} else {
					# Comparo los uidNumber de las entidades. 
					if ($u->entidad_verificadora->gidNumber == $usuario->entidad_verificadora->gidNumber) {
						my $mesg = $usuario->delete();	
						if ($mesg->done()){
							$c->stash->{mensaje} = "El usuario $uid ha sido eliminado";
						} else {
							$c->stash->{error} = 1;
							$c->stash->{mensaje} = $mesg->error_text();
						}
					} else {
						$c->stash->{error} = 1;
						$c->stash->{mensaje} = "Operación no permitida";
						utf8::decode($c->stash->{mensaje});
						$c->detach( 'CNTI1409::View::VistaPrincipal'); 
					}
				}
			}
		} else {
			$c->stash->{error} = 1;
			$c->stash->{mensaje} = "Usuario no encontrado";
		}
	} else {
		$c->stash->{error} = 1;
		$c->stash->{mensaje} = "No puede eliminar el usuario actual.";
	}
}

=head2 editar

Permite Editar un usuario. (Eliminar, Cambiar Password.)

=cut 

sub info : Local : Form {
	my ( $self, $c, $uid ) = @_;
	
	my ($user_entidad_id); 
	# Si es un usuario Auditor Jefe, solo puede ver la información de sus usuarios. 
	# Busco la entidad a la que pertenece el usuario. 
	if ($c->check_any_user_role("AuditorJefe") && !$c->check_any_user_role("Administrador")){
		my ($cn, $entidad) = &entidad($c->user,$self,$c);
		if ($entidad){
			$user_entidad_id = $entidad->gidNumber;	
		}
	}
	
	
	if (!$uid){
		$uid = $c->req->params->{uid};
	}
	$c->stash->{uid} = $uid;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
	$c->stash->{accion} = $c->req->params->{accion};
	#Busco la información del usuario. 
	my $usuario = $c->model('LDAP')->search(
		base   => $c->config->{base_usuarios},
		filter => "(&(objectClass=posixAccount)(uid=$uid))"
	)->shift_entry;
	
	my ($cn, $entidad) = &entidad($usuario,$self,$c) if $usuario;
	my ($rol) = &rol($usuario,$self,$c) if $usuario;


	if ($usuario) {
		$c->stash->{roles} = &rol($usuario,$self,$c);
		$c->stash->{usuario} = $usuario;
		$c->stash->{entidad} = $cn;
	} else {
		$c->stash->{error} = 1;
		$c->stash->{mensaje} = "Usuario no encontrado";
	}

	$c->stash->{template} = 'usuarios/info.tt2';

	if ($c->check_any_user_role(qw/AuditorJefe/) && !$c->check_any_user_role("Administrador")){
		if ($user_entidad_id && $entidad){
			if ($user_entidad_id != $entidad->gidNumber){
					$c->stash->{roles} = '';
					$c->stash->{usuario} = '';
					$c->stash->{error} = 1;
					$c->stash->{mensaje} = "Usuario no encontrado";
			}
		} else {
			$c->stash->{roles} = '';
			$c->stash->{usuario} = '';
			$c->stash->{error} = 1;
			$c->stash->{mensaje} = "Usuario no encontrado";
		}
	}

	if ($c->check_any_user_role("Auditor") && !$c->check_any_user_role("Administrador")){
		if ($uid ne $c->user->username){
			$c->stash->{roles} = '';
			$c->stash->{usuario} = '';
			$c->stash->{error} = 1;
			$c->stash->{mensaje} = "Usuario no encontrado";
		}
	}

	# Creo el formulario para actualizar el password
    my $form = $self->form;
	$form->load_config_file('usuarios/info.yml');
	my $fieldset = $form->get_element({ name => 'datos_fieldset' });
	my $h = $form->element('Hidden');
	$h->name('uid');
	$h->value($uid);
	$form->insert_before($h,$fieldset);
	$form->process;
	$c->stash->{form} = $form;
    if ($form->submitted_and_valid) {
		# Cambio de password. 

		my $uid 	= $c->req->params->{'uid'};
		my $passwd 	= $c->req->params->{'passwd'};

		my $usuario = $c->model('LDAP')->search(
			base   => $c->config->{base_usuarios},
			filter => "(&(objectClass=posixAccount)(uid=$uid))"
		)->shift_entry;
		if ($usuario){
			if ($c->check_any_user_role("Administrador")){
				$usuario = &change_password($usuario,$c->req->params->{passwd});
				my $mesg = $usuario->update();
				if ($mesg->done()){
					$c->log->debug("El usuario Administrador le ha cambiado la contraseña al usuario ".$usuario->uid);
		        	$c->response->redirect(
		            	$c->uri_for(
		                	$self->action_for('info'),
		                	{ uid => $uid, mensaje => "La contraseña ha sido cambiada con éxito" }
		           		)
		        	);
				}
			} elsif ($c->check_any_user_role("AuditorJefe")){
				# Puede cambiar el password de el mismo. 
				# Puede cambiar el password de usuarios auditores de su organizacion. 
				my $roles = &rol($usuario,$self,$c);
				if ($roles =~ m/Auditor/ || $roles =~ m/AuditorJefe/){
					my $usuario_entidad = &entidad($usuario,$self,$c);
					if ($c->user->username eq $usuario->uid ){
						$usuario = &change_password($usuario,$c->req->params->{passwd});
						my $mesg = $usuario->update();
						if ($mesg->done()){
							$c->log->debug("El usuario ".$usuario->uid." Actualizo su password");
				        	$c->response->redirect(
				            	$c->uri_for(
				                	$self->action_for('info'),
				                	{ uid => $uid, mensaje => "La contraseña ha sido cambiada con éxito" }
				           		)
				        	);
						}
					} elsif ( $usuario_entidad eq 'No Pertenece'){
						# Busco los roles del usuario. 	
						my $rol = &rol($usuario,$self,$c);
						if ($rol =~ m/Administrador/){
                            $c->log->debug(
								"ALERTA: Hay un intento de suplantación de identidad, por el usuario: ".$c->user->username
                            );
				        	$c->response->redirect(
				            	$c->uri_for(
				                	$self->action_for('info'),
				                	{ uid => $uid, mensaje => "Usuario no encontrado", error => 1 }
				           		)
				        	);
						} else {

						}
					} elsif ( $usuario_entidad->gidNumber == $user_entidad_id) {
						$usuario = &change_password($usuario,$c->req->params->{passwd});
						my $mesg = $usuario->update();
						if ($mesg->done()){
							$c->log->debug("El usuario ".$c->user->username." Actualizo el password de".$usuario->uid);
				        	$c->response->redirect(
				            	$c->uri_for(
				                	$self->action_for('info'),
				                	{ uid => $uid, mensaje => "La contraseña ha sido cambiada con éxito" }
				           		)
				        	);
						}

					}
				} else {
		        	$c->response->redirect(
		            	$c->uri_for(
		                	$self->action_for('info'),
		                	{ uid => $uid, mensaje => "Operación no permitida", error => 1 }
		           		)
		        	);
				}
			} elsif ($c->check_any_user_role("Auditor")){
				if ($uid ne $c->user->username){
					$c->log->debug("ALERTA: El usuario: ".$c->user->username. " Intenta cambiar el passwd de: ".$uid );
					$c->stash->{roles} = '';
					$c->stash->{usuario} = '';
					$c->stash->{error} = 1;
					$c->stash->{mensaje} = "Usuario no encontrado";
				} else {
					$usuario = &change_password($usuario,$c->req->params->{passwd});
					my $mesg = $usuario->update();
					if ($mesg->done()){
						$c->log->debug("El usuario ".$c->user->username." Actualizo su password. ");
				       	$c->response->redirect(
				           	$c->uri_for(
				               	$self->action_for('info'),
				               	{ uid => $uid, mensaje => "Su contraseña ha sido cambiada con éxito" }
				          		)
				       	);
					}
				}
			}
		}
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
	}

	# Creo el formulario para eliminar el usuario
    my $form2 = $self->form;
	$form2->load_config_file('usuarios/borrar.yml');
	my $fieldset = $form2->get_element({ name => 'datos_fieldset' });
	my $h = $form2->element('Hidden');
	$h->name('uid');
	$h->value($uid);
	$form2->insert_before($h,$fieldset);
	$form2->process;
	$c->stash->{form2} = $form2;
}

sub change_password {
	my ($usuario, $passwd) = @_;
	my $p = md5_base64($passwd);
	$p = "{MD5}".$p."==";
	$usuario->replace(userPassword => $p);
	return $usuario;
}

sub rol {
	my ($u,$self,$c) = @_;
	my $r = '';
	my @roles = $c->model('LDAP')->search(
		base => $c->config->{base_roles},
		filter => "(&(objectClass=posixGroup)(memberUid=".$u->uid."))",
	)->entries();
	foreach my $rol (@roles){
		$r = $rol->cn . " ".$r;	
	}
	return $r;
}

sub entidad {
	my ($u,$self,$c) = @_;
	# Busco si pertenece a una entidad
	my $entidad = $c->model('LDAP')->search(
		base   => $c->config->{base_entidades},
		filter => "(&(objectClass=posixGroup)(memberUid=".$u->uid."))"
	)->shift_entry;	
	if ($entidad && $entidad->gidNumber > 0){
		my $cn = $entidad->cn;
		utf8::decode($cn);
		return ($cn,$entidad);
	} else {
		return "No Pertenece";
	}
}
=head2 listar

Permite listar los usuarios del sistema

=cut

sub listar : Local {
	my ( $self, $c ) = @_;
	$c->stash->{template} = 'usuarios/listar.tt2';
}

=head2 crear 

Permite Crear Usuarios.

=cut 

sub crear : Local : Form {
	use Data::Dumper;
	my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $self->form;
	my ($entidad_id, $entidad_nombre, $idev);
	$c->stash->{template} = "usuarios/crear.tt2" ;

	if ($c->check_user_roles( qw/Administrador/ )){
		$form->load_config_file('usuarios/crear_administrador.yml');
	} elsif ($c->check_user_roles(qw/AuditorJefe/)){
		$c->req->params->{rol} = 'auditor';
		$form->load_config_file('usuarios/crear_auditor.yml');
		# Busco la entidad verificadora a la que pertenece el usuario. 
		my $usuario = $c->user->username;
        my $entidad = $c->model('LDAP')->search(
            base   => $c->config->{base_entidades},
            filter => "(&(objectClass=posixGroup)(memberUid=$usuario))"
        )->shift_entry;
		$entidad_id = $entidad->gidNumber;
		if ($entidad_nombre = $entidad->cn){
			$c->stash->{entidad} = $entidad_nombre;
			utf8::decode($entidad_nombre);
		}
	}
	$form->process;
	$c->stash->{form} = $form;
    if ($form->submitted_and_valid) {
		use Net::LDAP::Entry;
		my $entry = Net::LDAP::Entry->new();
		# Construyo el DN del usuario
		my $dn = "uid=".$c->req->params->{uid}.",".$c->config->{base_usuarios};
		$entry->dn($dn);
		# Agrego los atributos.
		my $cn = $c->req->params->{nombre}.' '.$c->req->params->{apellido};
		# Calculo el hash md5 del password. 
		$c->log->debug($c->req->params->{passwd});
		my $passwd = md5_base64($c->req->params->{passwd});
		$passwd = "{MD5}".$passwd."==";
		$c->log->debug($passwd);
		
        $entry->add(
            objectClass => [qw/top inetOrgPerson posixAccount/],
            cn          => $cn,
            uid         => $c->req->params->{uid},
			homeDirectory => "/home/users/".$c->req->params->{uid},
			givenName 	=> $c->req->params->{nombre},
			sn 			=> $c->req->params->{apellido},
			userPassword => $passwd,
			mail 		=> $c->req->params->{mail},
        );

		# Evaluo el rol. 
		# Si el rol es Auditor o Auditor Jefe, debo calcular el id de la entidad
		# Ya sea enviado desde el formulario, para cuando el usuario es Administrador, o lo busco 
		# en los datos del usuario, si es un AuditorJefe. 
		my $gidNumber;
		if ($c->req->params->{rol} eq 'auditor' || $c->req->params->{rol} eq 'auditorJefe'){
			$gidNumber = 1001 if $c->req->params->{rol} eq 'auditor'; 
			$gidNumber = 1002 if $c->req->params->{rol} eq 'auditorJefe'; 
			$entry->add(gidNumber => $gidNumber);

			if ($entidad_id eq '') {
				my $ev = $c->model('DB::Entidadverificadora')->find(
					{
						"lower(me.nombre)" => lc( $c->req->params->{idev} ),
						habilitado         => "true"
					},
					{ columns => [qw / id /] }
				);
				$c->log->debug($ev->id);
				$idev = $ev->id;
			} else {
				$idev = $entidad_id;
			}
			# Agrego el uid del usuario, al PosixGroup correspondiente a su entidad verificadora en LDAP.
	        my $entidad = $c->model('LDAP')->search(
	            base   => $c->config->{base_entidades},
	            filter => "(&(objectClass=posixGroup)(gidNumber=$idev))"
	        )->shift_entry;
			if ($entidad->exists("memberUid")) {
				my @members = $entidad->memberUid;
				push @members,$c->req->params->{uid};
				$entidad->replace(memberUid => \@members);
				$entidad->update();
			} else {
				$entidad->add(memberUid => [$c->req->params->{uid}]);
				$entidad->update();
			}

			# Agrego el uid del usuario, al PosixGroup correspondiente al ROL.
	        my $rol = $c->model('LDAP')->search(
	            base   => $c->config->{base_roles},
	            filter => "(&(objectClass=posixGroup)(gidNumber=$gidNumber))"
	        )->shift_entry;
			if ($rol->exists("memberUid")) {
				my @members = $rol->memberUid;
				push @members,$c->req->params->{uid};
				$rol->replace(memberUid => \@members);
				$rol->update();
			} else {
				$rol->add(memberUid => [$c->req->params->{uid}]);
				$rol->update();
			}

		} elsif ($c->req->params->{rol} eq 'administrador') {
			$gidNumber = 1000;
			$entry->add(gidNumber => $gidNumber);
			
			# El usuario administrador debe tener el rol Auditor y Auditor Jefe. 
	        my $rolAuditor = $c->model('LDAP')->search(
	            base   => $c->config->{base_roles},
	            filter => "(&(objectClass=posixGroup)(cn=Auditor))"
	        )->shift_entry;
			if ($rolAuditor->exists("memberUid")) {
				my @members = $rolAuditor->memberUid;
				push @members,$c->req->params->{uid};
				$rolAuditor->replace(memberUid => \@members);
				$rolAuditor->update();
			} else {
				$rolAuditor->add(memberUid => [$c->req->params->{uid}]);
				$rolAuditor->update();
			}

	        my $rolAuditorJefe = $c->model('LDAP')->search(
	            base   => $c->config->{base_roles},
	            filter => "(&(objectClass=posixGroup)(cn=AuditorJefe))"
	        )->shift_entry;
			if ($rolAuditorJefe->exists("memberUid")) {
				my @members = $rolAuditorJefe->memberUid;
				push @members,$c->req->params->{uid};
				$rolAuditorJefe->replace(memberUid => \@members);
				$rolAuditorJefe->update();
			} else {
				$rolAuditorJefe->add(memberUid => [$c->req->params->{uid}]);
				$rolAuditorJefe->update();
			}

		}

		# Agrego el uid del usuario, al PosixGroup correspondiente al ROL.
		my $rol = $c->model('LDAP')->search(
			base   => $c->config->{base_roles},
			filter => "(&(objectClass=posixGroup)(gidNumber=$gidNumber))"
		)->shift_entry;
		my @members = $rol->memberUid;
		push @members,$c->req->params->{uid};
		$rol->replace(memberUid => \@members);
		$rol->update();

		# En este punto, busco el próximo uidNumber que se encuentra en el usuario de mantenimiento. 
	    my $usuario_mantenimiento = $c->model('LDAP')->search(
	        base   => $c->config->{base_mantenimiento},
	        filter => "(&(objectClass=posixAccount)(uid=umantenimiento))"
	    )->shift_entry;
		my $uid_number = $usuario_mantenimiento->uidNumber;
		my $next_uid_number = $uid_number + 1;
		# Incremento el uid_number de mantenimiento.
		$usuario_mantenimiento->replace(uidNumber => $next_uid_number);

		# Asigno el ultimo atributo que me falta: uidNumber.
		$entry->add(uidNumber => $uid_number);	

		# Guardo los cambios en el LDAP para el usuario de Mantenimiento. 
		$usuario_mantenimiento->update();
			
		# Creo el nuevo usuario en LDAP.
		my $mesg = $c->model('LDAP')->add($entry);
		my ($error, $mensaje);
		if ($mesg->is_error()){
			$error = 1;
	        $mensaje = "El usuario" . $form->param_value('nombre') . " no se ha registrado en LDAP:".$mesg->error_text();
		} else {
			$error = 0;
	        $mensaje = "El usuario " . $form->param_value('nombre') . " se ha registrado con &eacute;xito en LDAP";
		}
        $c->response->redirect($c->uri_for($self->action_for('crear'),{ mensaje => $mensaje, error => $error}));
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
	}
}


=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

