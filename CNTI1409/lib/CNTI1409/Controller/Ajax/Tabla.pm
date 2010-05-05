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
	my $rs = $c->model('DB::Institucion')->search;
	my %data;
    $data{aaData} = [
       map {
           [
               $_->id,        $_->nombre,   $_->rif,
               $_->correo,    $_->telefono, $_->contacto,
               $_->direccion, $_->web,      
           ]
         } $rs->all
    ];
	$self->status_ok($c, entity => \%data);
}

sub instituciones_POST {
	my ($self, $c) = @_;
	use Data::Dumper;
	my $d = $c->req->data->{valor};
	my $i = $c->req->data->{id};
	$c->log->debug($d);
	$c->log->debug($i);
	$self->status_accepted(
               $c,
               entity => {
                   value => $d,
               }
	);
	
}
=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

