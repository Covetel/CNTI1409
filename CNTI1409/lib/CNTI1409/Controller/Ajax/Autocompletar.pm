package CNTI1409::Controller::Ajax::Autocompletar;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::REST'; }


__PACKAGE__->config(
  'default'   => 'application/javascript',
);


sub instituciones : Local : ActionClass('REST') {}
sub entidades : Local : ActionClass('REST') {}


=head1 NAME

CNTI1409::Controller::Ajax::Autocompletar - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Ajax::Autocompletar in Ajax::Autocompletar.');
}

=head2 instituciones_GET 

Este método, devuelve la lista de instituciones en JSON, para llenar el control autocomplete

=cut

sub instituciones_GET {
	my ($self, $c) = @_;
    my $requ = lc($c->req->params->{term});
	my $rs = $c->model('DB::Institucion')->search(
                                                    { 'lower(nombre)' => { like => "$requ%" }, habilitado => "true" },
                                                    { columns => [ qw / nombre / ] }
                                                );
	my @datos = map { { value => $_->nombre, label => $_->nombre } } $rs->all;
    $self->status_ok($c, entity => \@datos);
}

=head2 entidades_GET

Este método, devuelve la lista de entidades en JSON, para llenar el control autocomplete

=cut

sub entidades_GET {
	my ($self, $c) = @_;
    my $requ = lc($c->req->params->{term});
	my $rs = $c->model('DB::Entidadverificadora')->search(
                                                            { 'lower(nombre)' => { like => "$requ%" } },
                                                            { columns => [ qw / nombre / ] }
                                                         );
	my @datos = map { { value => $_->nombre, label => $_->nombre } } $rs->all;
    $self->status_ok($c, entity => \@datos);
}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

