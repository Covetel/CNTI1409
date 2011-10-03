#!/usr/bin/env perl
use strict;
use warnings;
use lib qw/lib/;
use CNTI::Validator::Jobs;
use CNTI::Validator::Monitor::Job;
use CNTI::Validator::Monitor::URL;

my $job = CNTI::Validator::Jobs->new_job(
    site => "http://fundabit.me.gob.ve",
    sample => [
'http://fundabit.me.gob.ve/',
'http://fundabit.me.gob.ve/#/images/favicon.ico',
'http://fundabit.me.gob.ve/index.php',
'http://fundabit.me.gob.ve/index.php?option=com_content&task=view&id=100&Itemid=78',
'http://fundabit.me.gob.ve/index.php?option=com_content&task=view&id=101&Itemid=68',
'http://fundabit.me.gob.ve/index.php?option=com_content&task=view&id=101&Itemid=78',
        ], 
);

my $j = CNTI::Validator::Jobs->find_job($job->id);
printf "El job %d tiene estado %s\n", $j->id, $j->state;

my $it = $j->children;

while ($j->state == 1){
    while (my $u = $it->()){
        printf "URL: %s %s %d\n", $u->uri, $u->fail, $u->state;
    }
    
}

1;
