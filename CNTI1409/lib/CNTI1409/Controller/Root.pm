package CNTI1409::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;
# Hola esto es un comentario
# prueba2 bichito

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

CNTI1409::Controller::Root - Root Controller for CNTI1409

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('login');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 login

Metodo utilizado para manejar el login

=cut

sub login : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) { 
        if ( my $user = $form->param_value('correo') and my $password = $form->param_value('password') ) {
            if ( $c->authenticate( { username => $user,
                                     password => $password } ) ) {
                $c->response->redirect($c->uri_for(
                                            $c->controller('Auditoria')->action_for('reporte')));

            } else {
                $c->stash->{error} = 1;
                $c->stash->{mensaje} = "Correo o Contraseña no válidos";
            }
        }
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        $c->stash->{mensaje} = "Correo o Contraseña no válidos";
    }
	$c->stash->{template} = 'ingresar.tt2';
}

sub logout : Local {
    my ($self, $c) = @_;

    # Clear the user's state
    $c->logout;

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
}


=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
