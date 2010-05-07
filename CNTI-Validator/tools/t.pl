
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;
use common::sense;

my @data = CNTI::Validator::Schema->resultset('Jobs')->all;

my $job = CNTI::Validator::Jobs->new_job(
    site => "http://www.mppef.gob.ve",
    sample => [
        "/nosotros",
        "/ellos",
        "/vosotros",
        ],
    callback => "http://validador.gob.ve/mi-callback",
    data => { algo => 1, mas => 2 }
);

my $j = CNTI::Validator::Jobs->find_job($job->id);

print "done\n";
