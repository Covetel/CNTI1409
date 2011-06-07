#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use utf8;

use CNTI::Spider::UA;
use CNTI::Spider::State;
use CNTI::Spider::UrlList;

$SIG{CHLD} = "IGNORE";

my $url = "http://www.cnti.gob.ve/";

my $spider = CNTI::Spider::State->new( base => $url, depth => 2, num => 20, dir => 0 );

my $pid = $spider->run;

if ($pid){
    print "$pid \n";
    print $spider->id , "\n"; 
    my $monitor = CNTI::Spider::State->new( id => $spider->id );
    while (1){
        $_ = <>;
      last if $_ =~ /exit/;
        if ($_ =~ /monitor/){
            $monitor->discard_changes; 
            print "Working...\n" if  $monitor->state < 2; 
            print "\n\n";
            my @q = $spider->queue;
            print scalar @q, " (n)\n";
            for ( $spider->queue ) {
                printf "%s %s\n", $_->sum, $_->title;
            }
        } 
        if ($_ =~ /kill/){
            print "Intentando matar al proceso $pid \n";
            my $kp = kill 9, $pid;
            if ($kp){
                print "Devolvio $kp\n";
                print $monitor->state, "(state)\n";
                
            } else {
                print "Kill no devuelve nada\n"; 
            }
        }
    }
}
