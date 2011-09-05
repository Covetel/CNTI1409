#!/usr/bin/env perl
use strict;
use warnings;
use lib qw{../CNTI1409/lib/};
use Validador::Esquema;
use utf8;
use JSON;
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
#my $json_disp = JSON::XS->new->utf8(1)->encode($disp);
#my $json_disp = to_json($disp, {utf8 => 1});

#my $json_db = $schema->resultset('AuditoriaResult')->create({
#        id_auditoria => $auditoria->id, 
#       json => $json_disp, 
#});

#my $scalar = $auditoria->results->fromjson;
use YAML;
print YAML::Dump($disp);


1;
