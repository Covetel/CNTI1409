package CNTI::Validator::Schema;
use Moose;

use CNTI::ValidatorDB;

my $schema = CNTI::ValidatorDB->connect( 'dbi:Pg:host=localhost;dbname=validador;port=5432', 'admin', '123321...',{pg_enable_utf8 => 1} );

sub schema { $schema }
sub resultset { $schema->resultset($_[1]) }


no Moose;
__PACKAGE__->meta->make_immutable;
1

