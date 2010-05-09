package CNTI::Validator::Schema;
use Moose;

use CNTI::ValidatorDB;

my $schema = CNTI::ValidatorDB->connect( 'dbi:Pg:dbname=validador;port=5433', 'opr', '', );

sub schema { $schema }
sub resultset { $schema->resultset($_[1]) }


no Moose;
__PACKAGE__->meta->make_immutable;
1

