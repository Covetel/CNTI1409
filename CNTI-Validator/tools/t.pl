
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;
use common::sense;

my @data = CNTI::Validator::Schema->resultset('Jobs')->all;

my $job = CNTI::Validator::Jobs->new_job(
    site => "http://www.mppef.gob.ve",
    sample => [
        "/inicio/notas-de-prensa",
        "/inicio/publicaciones",
        "/inicio/info.-estadistica",
        "/inicio/concursos-abiertos",
        ],
    callback => "http://validador.gob.ve/mi-callback",
    data => { algo => 1, mas => 2 }
);

my $j = CNTI::Validator::Jobs->find_job($job->id);
printf "Job : %d\n", $j->id;
printf "Site: %s\n", $j->site;
printf "Call: %s\n", $j->cb   if $j->cb;
printf "Data: %s\n", $j->data if $j->data;
printf "Stat: %s\n", $j->state;
printf "Samples:\n";
my $it = $j->children;
while ( my $u = $it->() ) {
    printf "    %s\n", $u->path;
}

while ( $j->state ne "done" ) { 
    printf "Wait for termination (%s)\n", $j->state;
    $j->refresh;
    sleep(1);
}

use YAML;

print YAML::Dump $j->as_hash;
print $j->as_json;

#CNTI::Validator::Jobs->cancel_job( $j->id );
#CNTI::Validator::Jobs->delete_job( $j->id );
$j->refresh;
print YAML::Dump $j->as_hash;
print "done\n";
