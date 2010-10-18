package CNTI1409::SOAP::Auditorias;
use Moose;
use Validador::Esquema;
use Config::Any::YAML;

my $config = Config::Any::YAML->load("../configuracion.yml");

my $schema = Validador::Esquema->connect(
    $config->{'Model::DB'}->{connect_info}->{dsn},
    $config->{'Model::DB'}->{connect_info}->{user},
    $config->{'Model::DB'}->{connect_info}->{password},
    { pg_enable_utf8 => 1 }
);


