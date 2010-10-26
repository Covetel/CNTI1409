#!/usr/bin/perl -w
use strict;
use warnings;

use SOAP::Lite; 
use Data::Dumper;

my $soap = SOAP::Lite->uri("http://localhost/soap/")->proxy("http://192.168.1.241:3000/soap/");

#my $auditoria = $soap->getAuditoria(121)->result();
my $auditoria = $soap->getAuditoria(114)->result();
my @auditorias = $soap->get_lista_auditorias('c')->result();

print Dumper $auditoria;
print Dumper @auditorias;

print "El portal es: ", $auditoria->{'portal'}, "\n";
print "La institucion es: ", $auditoria->{'institucion'}, "\n";

