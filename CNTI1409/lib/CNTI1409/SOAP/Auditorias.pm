package CNTI1409::SOAP::Auditorias;
use Moose;
use Validador::Esquema;
use Config::Any::YAML;

# Cargo la configuracion
my $config = Config::Any::YAML->load("../configuracion.yml");

# Conexion a la base de datos. 
	my $schema = Validador::Esquema->connect(
   		$config->{'Model::DB'}->{connect_info}->{dsn},
   		$config->{'Model::DB'}->{connect_info}->{user},
   		$config->{'Model::DB'}->{connect_info}->{password},
   		{ pg_enable_utf8 => 1 }
	);


# Declaracion de la clase. 

sub _schema {
	return $schema;
}

sub totalAuditorias {
	my ($self) = @_;
	my $rs = $self->_schema->resultset('Auditoria')->search();
	my $total = $rs->count();
	return $total;
}

sub totalAuditoriasCerradas {
	my ($self) = @_;
	my $rs = $self->_schema->resultset('Auditoria')->search({ estado => 'c'});
	my $total = $rs->count();
	return $total;
}

sub totalAuditoriasAbiertas {
	my ($self) = @_;
	my $rs = $self->_schema->resultset('Auditoria')->search({ estado => 'a'});
	my $total = $rs->count();
	return $total;
}

sub totalAuditoriasPendientes {
	my ($self) = @_;
	my $rs = $self->_schema->resultset('Auditoria')->search({ estado => 'p'});
	my $total = $rs->count();
	return $total;
}

sub listaAuditorias {
	my ($self) = @_;
	my @auditorias;
	my $rs = $self->_schema->resultset('Auditoria')->search({estado => 'c'});
	foreach my $auditoria ($rs->all){
		my $a; 
		$a->{'idauditoria'} = $auditoria->id;
		$a->{'portal'} = $auditoria->portal;
		$a->{'entidadverificadora'} = $auditoria->idev->nombre;
		$a->{'institucion'} = $auditoria->idinstitucion->nombre;
		$a->{'disposicionesfallidas'} = $auditoria->fallidas;
		$a->{'disposicionesvalidas'} = $auditoria->validas;
		$a->{'disposicionestotal'} = $auditoria->validas + $auditoria->fallidas;
		push @auditorias, $a;
	}
	return @auditorias;
}
	

sub mensaje {
	return "Esto es un mensaje";
}

1;
