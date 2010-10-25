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

=head2 auto

Redirecciona a Login.

=cut

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

sub exists : Local {
	my ( $self, $c, $uid ) = @_;
	my $resp = {};
	$resp->{exists} = $c->model('LDAP')->user_exists($uid);
    $self->status_ok($c, entity => $resp);
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

