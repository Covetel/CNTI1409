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
               $_->direccion, $_->web,      &field_habilitado($_->habilitado,$_->id,"instituciones"),
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
               $_->contacto,  $_->direccion, $_->web,      
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
	my $rs = $c->model('DB::Auditoria')->search({},{join => 'idev', join => 'idinstitucion'});
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

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
