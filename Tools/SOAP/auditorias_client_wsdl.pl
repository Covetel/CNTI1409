#!/usr/bin/perl -w
use strict;
use warnings;

use SOAP::Lite +trace => 'all';
use Data::Dumper;

my $soap = SOAP::Lite->service('http://localhost:3000/static/wsdl/Auditoria.wsdl');
my $r = $soap->getAuditoria(1);
print Dumper $r;
