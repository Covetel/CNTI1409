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

