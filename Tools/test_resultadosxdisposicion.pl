#!/usr/bin/env perl
use strict;
use warnings;
use lib qw{../CNTI1409/lib/};
use Validador::Esquema;
use JSON::XS;
use Data::Dumper;

my $dsn = "dbi:Pg:dbname=validador;host=192.168.56.101";
my $schema = Validador::Esquema->connect($dsn,"admin", "123321...");

my $id = shift;

my $auditoria = $schema->resultset('Auditoria')->find($id);
my $jobid = $auditoria->job;

#my $jobid = shift;
my $dispid = shift;

# Busco las disposiciones. 
my $disp = $schema->resultset('ResultadosDisposicion')->disposiciones($jobid,$dispid);
my $json_disp = encode_json $disp;

my $disp2 = decode_json $json_disp;

print Dumper $disp2;

1;
