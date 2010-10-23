package CNTI1409::Controller::SOAP;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::SOAP'; }

__PACKAGE__->config->{wsdl} =
  	{
	wsdl => 'SOAP/Esquemas/Auditoria.wsdl',
   	schema => 'SOAP/Esquemas/Auditoria.xsd'
	};

=head1 NAME

CNTI1409::Controller::SOAP - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub getAuditoria: WSDLPort('AuditoriaSOAP')  {
	my ( $self, $c, $id ) = @_;
	use Data::Dumper;
	$c->log->debug(Dumper($id));
	my $a; 
	$a->{'idauditoria'} = 1;
	$a->{'portal'} = 'Portal de pruebas';
	$a->{'entidadverificadora'} = 'Cooperativa Venezolana de Tecnologias Libres R.S.';
	$a->{'institucion'} = 'Centro Nacional de Tecnologias de Informacion';
	$a->{'disposicionesfallidas'} = 10;
	$a->{'disposicionesvalidas'} = 6;
	$a->{'nombre'} = 'paja';
	$c->stash->{soap}->compile_return({Auditoria => $a});
}

sub get_mensaje :WSDLPort('AuditoriaSOAP')  {
	my ( $self, $c, $mensaje ) = @_;
	use Data::Dumper;
	$c->log->debug(Dumper($mensaje));
	$c->stash->{soap}->compile_return({mensaje => 'mensaje_salida_prueba'});
}

#sub index :Local SOAP('RPCEndpoint') {}

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

