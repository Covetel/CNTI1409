package CNTI::Spider::Schema;
use Moose;
use CNTI::SpiderDB;

my $dbfile  = "spiderdb"
my $dsn 	= "dbi:SQLite:dbname=" . $dbfile;
my $user 	= "";
my $passwd 	= "";

my $schema = CNTI::SpiderDB->connect( $dsn, $user, $passwd,{AutoCommit => 1} );
#my $schema = CNTI::SpiderDB->connect( $dsn, $user, $passwd,{pg_enable_utf8 => 1} );

sub schema { $schema }
sub resultset { $schema->resultset($_[1]) }


no Moose;
__PACKAGE__->meta->make_immutable;
1
