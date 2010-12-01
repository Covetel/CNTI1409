package CNTI1409::Controller::Ajax::Tabla;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  'default'   => 'application/json',
);

sub auto :Private {
    my ( $self, $c ) = @_;
    if ($c->controller eq $c->controller('Root')->action_for('login')) {
        return 1;
    }
    if (!$c->user_exists) {
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }
    return 1;
}

sub instituciones : Local : ActionClass('REST') {}

=head1 NAME

CNTI1409::Controller::Ajax::Tabla - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

=head2 instituciones_GET

Procesa la petición de datos por GET

=cut

sub field_habilitado {
	my ($habilitado, $id, $tabla) = @_;
	if ($habilitado == 1) {
		return "<div class='button'><button id='".$tabla."_desactivar_".$id."' class='desactivar'>Desactivar</button></div>";
	} 
	if ($habilitado != 1) {
		return "<div class='button'><button id='".$tabla."_activar_".$id."' class='activar'>Activar</button></div>";
	}
}

sub instituciones_GET {
	my ($self, $c) = @_;
	my $rs = $c->model('DB::Institucion')->search({},{order_by => 'habilitado'});
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->nombre,   $_->rif,
               $_->correo,    $_->telefono, $_->contacto,
               ($_->direccion) ? $_->direccion : '', $_->web,      
				"<button class='editar' id='instituciones_".$_->id."' class='ui-button ui-button-pencil'> Editar </button>",
				&field_habilitado($_->habilitado,$_->id,"instituciones"), 
           ]
         } $rs->all
    ];
	$self->status_ok($c, entity => \%data);
}

sub instituciones_POST {
	my ($self, $c) = @_;
	my $valor = $c->req->data->{valor};
	my $id = $c->req->data->{id};
    my $campo = $c->req->data->{campo};
    my $rs = $c->model('DB::Institucion')->find($id);
    $rs->$campo($valor);
    $rs->update;
	$self->status_accepted(
               $c,
               entity => {
                   value => $valor,
               }
	);
}

sub instituciones_DELETE {
	my ($self, $c) = @_;
	my $id = $c->req->data->{codigo};
	# Se debe validar que la institución no esta en uso en una auditoría abierta o pendiente. 
    my $rs = $c->model('DB::Institucion')->find($id);
	my $auditorias_rs = $rs->search_related('auditorias',{-or => [estado => 'a', estado => 'p']});
	if ($auditorias_rs == 0){
    	$rs->habilitado("false");
    	$rs->update;
    	$self->status_ok($c, entity => { valor => 1,});
	} else {
    	$self->status_ok($c, entity => { valor => 403, auditoria => $auditorias_rs->first->portal});
	}
}

sub instituciones_PUT : Local {
	my ( $self, $c ) = @_;
	my $id = $c->req->data->{codigo};
    my $rs = $c->model('DB::Institucion')->find($id);
    $rs->habilitado("true");
    $rs->update;
    $self->status_ok($c, entity => { valor => 1,});
}

=head2 Metaetiquetas

Seccion REST para procesar las meta etiquetas

=cut
sub metaetiquetas : Local : ActionClass('REST') {}

sub metaetiquetas_GET {
    use DateTime;
    my ($self, $c) = @_;
    my $rs;
    $rs = $c->model('DB::Param')->search({ disposicion => 'Meta' });
    my %data;
    $data{aaData} = [
        map {[
                $_->id, $_->disposicion,    $_->parametro,
                "<div class='button'><button id='metas_".$_->id."' class='borrar'>Eliminar</button></div>",
            ]} $rs->all
    ];
    $self->status_ok($c, entity => \%data);
}

sub metaetiquetas_POST {
	my ($self, $c) = @_;
	my $valor = $c->req->data->{valor};
	my $id = $c->req->data->{id};
    my $campo = $c->req->data->{campo};
    my $rs = $c->model('DB::Param')->find($id);
    $rs->$campo($valor);
    $rs->update;
	$self->status_accepted(
               $c,
               entity => {
                   value => $valor,
               }
	);
}


sub metaetiquetas_DELETE {
	my ($self, $c) = @_;
	my $id = $c->req->data->{codigo};
	# Se debe validar que la institución no esta en uso en una auditoría abierta o pendiente. 
    my $rs = $c->model('DB::Param')->find($id);
    $rs->delete;
    $self->status_ok($c, entity => { valor => 1,});
}



=head2 Entidades

Seccion REST para procesar las entidades verificadoras

=cut

sub entidades : Local : ActionClass('REST') {}

sub entidades_GET {
	my ($self, $c) = @_;
	my $rs = $c->model('DB::Entidadverificadora')->search({});
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->registro,  $_->nombre,   
               $_->rif,       $_->correo,    $_->telefono, 
               $_->contacto,  ($_->direccion) ? $_->direccion : '', $_->web,      
				"<button class='editar' id='entidades_".$_->id."' class='ui-button ui-button-pencil'> Editar </button>",
			   &field_habilitado($_->habilitado,$_->id,"entidades"),

           ]
         } $rs->all
    ];
	$self->status_ok($c, entity => \%data);
}

sub entidades_POST {
	my ($self, $c) = @_;
	my $valor = $c->req->data->{valor};
	my $id = $c->req->data->{id};
    my $campo = $c->req->data->{campo};
    my $rs = $c->model('DB::Entidadverificadora')->find($id);
    $rs->$campo($valor);
    $rs->update;
	$self->status_accepted(
               $c,
               entity => {
                   value => $valor,
               }
	);
}

sub entidades_DELETE {
	my ($self, $c) = @_;
	my $id = $c->req->data->{codigo};
    my $rs = $c->model('DB::Entidadverificadora')->find($id);
	my $auditorias_rs = $rs->search_related('auditorias',{-or => [estado => 'a', estado => 'p']});
	if ($auditorias_rs == 0){
    	$rs->habilitado("false");
    	$rs->update;
    	$self->status_ok($c, entity => { valor => 1,});
	} else {
    	$self->status_ok($c, entity => { valor => 403, auditoria => $auditorias_rs->first->portal});
	}
}

sub entidades_PUT : Local {
	my ( $self, $c ) = @_;
	my $id = $c->req->data->{codigo};
    my $rs = $c->model('DB::Entidadverificadora')->find($id);
    $rs->habilitado("true");
    $rs->update;
    $self->status_ok($c, entity => { valor => 1,});
}




sub auditorias : Local : ActionClass('REST') {}

sub auditorias_GET {
	sub estado {
		my ($estado) = @_;
		return 'Cerrada' if $estado eq 'c';
		return 'Abierta' if $estado eq 'a';
		return 'Pendiente' if $estado eq 'p';
	}
    use DateTime;
	my ($self, $c) = @_;
	my @roles = $c->user->roles();
	my $rs;
	# Si el usuario es Administrador, lo ve todo. 
	if ($c->check_user_roles( qw/Administrador/ )){
		$rs = $c->model('DB::Auditoria')->search({},{join => 'idev', join => 'idinstitucion'});
	} elsif ($c->check_user_roles( qw/AuditorJefe/ ) || $c->check_user_roles( qw/Auditor/ )){
		# Busco la entidad verificadora a la que pertenece el usuario. 
		my $usuario = $c->user->username;
        my $entidad = $c->model('LDAP')->search(
            base   => $c->config->{base_entidades},
            filter => "(&(objectClass=posixGroup)(memberUid=$usuario))"
        )->shift_entry;
		my $entidad_id = $entidad->gidNumber;
		$rs = $c->model('DB::Auditoria')->search({idev => $entidad_id},{join => 'idev', join => 'idinstitucion'});
	}
	
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->idev->nombre,   $_->idinstitucion->nombre,
               $_->portal,    $_->fechacreacion->dmy(),  $_->fechaini ? $_->fechaini->dmy() : "N/A",
               $_->fechafin ? $_->fechafin->dmy() : "N/A", &estado($_->estado) ,
           ]
         } $rs->all
    ];
	$self->status_ok($c, entity => \%data);
}

sub usuarios : Local : ActionClass('REST') {}

sub usuarios_GET {
	use Data::Dumper;
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
			return $cn;
		} else {
			return "No Pertenece";
		}
	}
	sub info {
		my ($u) = @_;
		my $admin = "<a href='/usuarios/info/".$u->uid."'>Detalle</a>";
		return $admin;
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
	my ($self, $c) = @_;
	# Si el usuario es administrador ve a todos los usuarios. 
	if ($c->check_user_roles( qw/Administrador/ )){
		# Busco todos los usuarios, todas las cuentas del tipo posixAccount.
        my @usuarios = $c->model('LDAP')->search(
         	base   => $c->config->{base_usuarios},
           	filter => "(&(objectClass=posixAccount)(uid=*))"
        )->entries();
		my %data;
    $data{aaData} = [
        map {
            [
                $_->uid, $_->cn, $_->mail, $_->uidNumber,
                &entidad( $_, $self, $c ),
                &rol( $_, $self, $c ),
                &info($_)
            ]
          } @usuarios
    ];
		$self->status_ok($c, entity => \%data);
	} elsif ($c->check_user_roles( qw/AuditorJefe/ )){
		# Busco la entidad verificadora a la que pertenece el usuario. 
		my $usuario = $c->user->username;
        my $entidad = $c->model('LDAP')->search(
            base   => $c->config->{base_entidades},
            filter => "(&(objectClass=posixGroup)(memberUid=$usuario))"
        )->shift_entry;
		my $entidad_id = $entidad->gidNumber;
		
		# Busco todos los miembros de esa entidad. 
		my @uids = $entidad->memberUid;
		my @usuarios;
		foreach my $uid (@uids) {
			# Busco los datos del usuario en LDAP.
        	my $usuario = $c->model('LDAP')->search(
           	 	base   => $c->config->{base_usuarios},
            	filter => "(&(objectClass=posixAccount)(uid=$uid))"
        	)->shift_entry;
			push @usuarios,$usuario;	
		}
		my %data;
    $data{aaData} = [
        map {
            [
                $_->uid,  $_->cn,
                $_->mail, $_->uidNumber,
                &entidad( $_, $self, $c ), &rol($_, $self, $c),
                &info($_)
            ]
          } @usuarios
    ];
		$self->status_ok($c, entity => \%data);

	} 
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
