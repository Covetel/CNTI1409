package CNTI1409::Controller::Ajax::Usuario;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  'default'   => 'application/json',
);

=head1 NAME

CNTI1409::Controller::Ajax::Usuario - Alimenta al objeto Covetel.Usuario.

=head1 DESCRIPTION

Se encarga de alimentar al objeto Covetel.Usuario con la información correspondiente del usuario de la plataforma.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Ajax::Usuario in Ajax::Usuario.');
}

=head2 datos 

Devuelve un hash con los datos del usuario. 

=cut

sub datos : Local {
	my ( $self, $c ) = @_;
	my $usuario = {};
	$usuario->{uid} = $c->user->username;
	$usuario->{cn} = $c->user->cn;
	$usuario->{roles} = [$c->user->roles];
    $self->status_ok($c, entity => $usuario);
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

