#!/usr/bin/perl -w
use strict;
use warnings;

use SOAP::Lite; 
use Data::Dumper;

my $soap = SOAP::Lite->uri("http://localhost/soap/")->proxy("http://127.0.0.1:3000/soap/");

my $auditoria = $soap->getAuditoria(10)->result();
my $mensaje = $soap->get_mensaje('Esto es un mensaje')->result();

print Dumper $mensaje;
print Dumper $auditoria;

