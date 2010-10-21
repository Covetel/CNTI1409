#!/usr/bin/perl -w
use warnings;

my $init = {
 'schema_namesp' => 'http://localhost:8083/CNTI1409/SOAP/Auditorias.xsd',
 'services' => 'CNTI1409/SOAP/Auditorias',
 'service_name' => 'CNTI1409/SOAP/Auditorias',
 'target_namesp' => 'http://localhost:8083/CNTI1409/SOAP/Auditorias.wsdl',
 'documentation' => 'Auditorias',
 'location' => 'http://localhost:8083/CNTI1409/SOAP/Auditorias'
};

use WSDL::Generator;

my $w = WSDL::Generator->new($init);
my $r = CNTI1409::SOAP::Auditorias->totalAuditorias();
print $w->get('CNTI1409::SOAP::Auditorias');


