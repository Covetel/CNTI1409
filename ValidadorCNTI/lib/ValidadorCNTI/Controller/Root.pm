package ValidadorCNTI::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NOMBRE

ValidadorCNTI::Controller::Root - Controladora Raíz de ValidadorCNTI

=head1 DESCRIPCION

Esta es la controladora principal del sistema

=head1 METODOS

=cut

=head2 index

Este es el método principal de la controladora, se encarga de despachar y entregrar el control de la 
aplicación a la controladora correspondiente. 

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->forward("/portales/upload/")
}

=head2 default

Este método se encarga de capturar todas aquellas solicitudes que no se encuentren definidas en otra controladora. 

=cut 
sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Intenta Crear la vista, si es necesaria. 

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Cooperativa Venezolana de Tecnologías Libres R.S. <info@covetel.com.ve>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
