#!/usr/bin/env perl
use strict;
use warnings;
use lib qw/lib/;
use CNTI::Validator::Jobs;
use CNTI::Validator::Monitor::Job;
use CNTI::Validator::Monitor::URL;

my $job = CNTI::Validator::Jobs->new_job(
    site => "http://192.168.5.240",
    sample => [
"/", 
"/lenny/", 
"/lenny/?C=D;O=A", 
"/lenny/?C=M;O=A", 
"/lenny/?C=M;O=D", 
        ], 
);

my $j = CNTI::Validator::Jobs->find_job($job->id);
printf "El job %d tiene estado %s\n", $j->id, $j->state;

my $it = $j->children;

while (my $u = $it->()){
    printf "URL: %s\n", $u->uri;
}


1;
