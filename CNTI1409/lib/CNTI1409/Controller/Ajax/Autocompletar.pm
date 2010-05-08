package CNTI1409::Controller::Ajax::Autocompletar;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::REST'; }


__PACKAGE__->config(
  'default'   => 'application/json',
);


sub instituciones : Local : ActionClass('REST') {}


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

sub instituciones_GET {
	my ($self, $c) = @_;
    my $requ = $c->req->params->{q};
	my $rs = $c->model('DB::Institucion')->search({ 'lower(nombre)' => { -like => "$requ%" } });
	my %dato;
    $dato{item} = [
       map {
           [
               $_->id,        $_->nombre,
           ]
         } $rs->all
    ];
    $self->status_ok($c, entity => \%dato);
}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

