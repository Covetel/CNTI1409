package CNTI1409::Controller::Ajax::Tabla;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  'default'   => 'application/json',
);


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

sub instituciones_GET {
	my ($self, $c) = @_;
	my $rs = $c->model('DB::Institucion')->search({ habilitado => "true" });
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->nombre,   $_->rif,
               $_->correo,    $_->telefono, $_->contacto,
               $_->direccion, $_->web,      "<div class='borrar' id='borrar_" . $_->id . "'></div>",
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
    my $rs = $c->model('DB::Institucion')->find($id);
    $rs->habilitado("false");
    $rs->update;
    $self->status_ok($c, entity => { valor => 1,});
}

=head2 Entidades

Seccion REST para procesar las entidades verificadoras

=cut

sub entidades : Local : ActionClass('REST') {}

sub entidades_GET {
	my ($self, $c) = @_;
	my $rs = $c->model('DB::Entidadverificadora')->search({ habilitado => "true" });
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->nombre,   $_->rif,
               $_->correo,    $_->telefono, $_->contacto,
               $_->direccion, $_->web,      "<div class='borrar' id='borrar_" . $_->id . "'></div>",
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
    $rs->habilitado("false");
    $rs->update;
    $self->status_ok($c, entity => { valor => 1,});
}

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

