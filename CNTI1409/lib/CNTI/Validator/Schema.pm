package CNTI::Validator::Schema;
use Moose;
use CNTI1409;
use CNTI::ValidatorDB;

=head1 Configuración

Se toman los valores de configuración directamente del módulo CNTI1409::Model::DB.

=cut 

my $dsn 	= CNTI1409::Model::DB->config->{'connect_info'}->{'dsn'};
my $user 	= CNTI1409::Model::DB->config->{'connect_info'}->{'user'};
my $passwd 	= CNTI1409::Model::DB->config->{'connect_info'}->{'password'};

#my $schema = CNTI::ValidatorDB->connect( $dsn, $user, $passwd,{pg_enable_utf8 => 1} );
my $schema = CNTI::ValidatorDB->connect( 'dbi:Pg:host=localhost;dbname=validador;port=5432', 'admin', '123321...',{pg_enable_utf8 => 1} );

sub schema { $schema }
sub resultset { $schema->resultset($_[1]) }


no Moose;
__PACKAGE__->meta->make_immutable;
1

