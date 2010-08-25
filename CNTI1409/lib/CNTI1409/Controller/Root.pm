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

sub pdf : Local {
	my ( $self, $c ) = @_;
	$c->stash->{name} = 'Walter Vargas';
	my $auditoria = {};
	$auditoria->{id} = '0002';
	$c->stash->{auditoria} = $auditoria;
	my @datos = qw/uno dos tres cuatro cinco seis/;
	my $file = "reporte-0002.pdf";
	$c->stash->{datos} = \@datos;
	if ($c->forward( 'CNTI1409::View::PDF' ) ) {
     # Only set the content type if we sucessfully processed the template
     $c->response->content_type('application/pdf');
     $c->response->header('Content-Disposition', "attachment; filename=$file");
  	}

}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/login');
}

=head2 inicio

Inicio de la aplicación.

=cut

sub inicio : Local {
	my ( $self, $c ) = @_;
    if (!$c->user_exists) {
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }
	$c->stash->{template} = 'inicio.tt2';
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
    if ($c->user_exists) {
        $c->response->redirect($c->uri_for('/inicio'));
        return 1;
    }
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) { 
        if ( my $user = $form->param_value('correo') and my $password = $form->param_value('password') ) {
            if ( $c->authenticate( { username => $user,
                                     password => $password } ) ) {
                $c->response->redirect($c->uri_for($c->controller('Root')->action_for('inicio')));
                return;

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
