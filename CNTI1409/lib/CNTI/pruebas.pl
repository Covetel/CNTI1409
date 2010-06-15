#!/usr/bin/perl -w
use strict;
use warnings;
use lib qw(../);
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;


my $job = CNTI::Validador::Jobs->find_job( 9 );

# Busco los hijos, o urls de este job. 

my $it = $job->children;

while (my $u = $it->()) {
	#Obtengo el los hijos de las url, que son las disposiciones.
	my $it2 = $u->children;
	print $u->url,"\n";
	while(my $r = $it2->()){
	}
}
