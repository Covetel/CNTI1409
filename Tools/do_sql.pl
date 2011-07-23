#!/usr/bin/env perl
use strict;
use warnings;

use DBI; 
use Data::Dumper;

chomp(my $sql = shift);

my $dbh = DBI->connect("dbi:Pg:dbname=validador;host=192.168.5.126",
    "admin","123321...");

my $ary_ref  = $dbh->selectrow_arrayref($sql);

while (1){
print Dumper $ary_ref;
print "\n";
}
