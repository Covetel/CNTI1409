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

=head2 getAuditoria (AuditoriaId) 

 Este método recibe el id de la auditoria y devuelve un hash con la información
 de la auditoria.

=cut 

sub getAuditoria: WSDLPort('AuditoriaSOAP')  {
	my ( $self, $c, $parametro ) = @_;
	my $a; 
	my $auditoria = $c->model('DB::Auditoria')->find($parametro->{'AuditoriaId'});
	if ($auditoria) {
		$a->{'idauditoria'} = $auditoria->id;
		$a->{'portal'} = $auditoria->portal;
		$a->{'entidadverificadora'} = $auditoria->idev->nombre;
		$a->{'institucion'} = $auditoria->idinstitucion->nombre;
		$a->{'disposicionesfallidas'} = $auditoria->fallidas;
		$a->{'disposicionesvalidas'} = $auditoria->validas;
		$a->{'nombre'} = $auditoria->idev->nombre . " " . $auditoria->portal;
		$c->stash->{soap}->compile_return({Auditoria => $a});
	} else {
        $c->stash->{soap}->fault(
            {
                code   => 'Server',
                reason => 'Auditoria no encontrada',
                detail => 'El Id que proporciono no fue encontrado en la base de datos.'
            }
        );
	}
}

=head2 get_mensaje (mensaje) 

 Método que devuelve un mensaje de prueba

=cut 

sub get_mensaje :WSDLPort('AuditoriaSOAP')  {
	my ( $self, $c, $mensaje ) = @_;
	$c->stash->{soap}->compile_return({mensaje => 'mensaje_salida_prueba'});
}

=head2 get_lista_auditorias () 

 Devuelve la lista de auditorias.

=cut 

sub get_lista_auditorias : WSDLPort('AuditoriaSOAP') {
	my ( $self, $c, $parametro ) = @_;
	my $auditorias = [];
	my @rs = $c->model('DB::Auditoria')->search({})->all;
	foreach my $auditoria (@rs) {
		my $a;
		$a->{'idauditoria'} = $auditoria->id;
		$a->{'portal'} = $auditoria->portal;
		$a->{'entidadverificadora'} = $auditoria->idev->nombre;
		$a->{'institucion'} = $auditoria->idinstitucion->nombre;
		$a->{'disposicionesfallidas'} = $auditoria->fallidas | -1;
		$a->{'disposicionesvalidas'} = $auditoria->validas | -1;
		$a->{'nombre'} = $auditoria->idev->nombre . " " . $auditoria->portal;
		push @$auditorias, $a;
	}
	$c->stash->{soap}->compile_return({ ListaAuditorias => { Auditoria => $auditorias } });
}

#sub index :Local SOAP('RPCEndpoint') {}

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

