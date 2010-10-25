#!/usr/bin/perl -w
use strict;
use warnings;

use SOAP::Lite; 
use Data::Dumper;

my $soap = SOAP::Lite->uri("http://localhost/CNTI1409/SOAP/Auditorias")->proxy("http://127.0.0.1:8083");

my $n = 10;

my $resultado = $soap->totalAuditorias()->result();

print "El resultado es: ". $resultado . "\n";
print "El resultado Cerradas es: ". $soap->totalAuditoriasCerradas()->result() . "\n";
print "Lista de auditorias: ". $soap->listaAuditorias()->result() . "\n";

my @auditorias = $soap->listaAuditorias()->result();

my @list = $soap->listaAuditorias()->paramsout;

print Dumper @auditorias;
print Dumper @list;
