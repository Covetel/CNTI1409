#!/usr/bin/perl -w
use strict;
use warnings;
use CNTI1409::SOAP::Server; 

print "La direccion es : ";
my $servidor = CNTI1409::SOAP::Server->new(address => 'localhost', port => '8083');
$servidor->clase('CNTI1409::SOAP::Auditorias');
$servidor->start;
