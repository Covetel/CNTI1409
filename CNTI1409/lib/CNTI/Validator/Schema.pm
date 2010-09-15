package CNTI::Validator::Schema;
use Moose;
use CNTI::ValidatorDB;
use Config::Any::YAML;

=head1 Configuración

Se toman los valores de configuración directamentedel archivo configuracion.yml

=cut 

my $config = Config::Any::YAML->load("configuracion.yml");

my $schema = CNTI::ValidatorDB->connect(
    $config->{'Model::DB'}->{connect_info}->{dsn},
    $config->{'Model::DB'}->{connect_info}->{user},
    $config->{'Model::DB'}->{connect_info}->{password},
    { pg_enable_utf8 => 1 }
);

sub schema { $schema }
sub resultset { $schema->resultset($_[1]) }


no Moose;
__PACKAGE__->meta->make_immutable;
1

