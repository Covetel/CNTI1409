#!/usr/bin/env perl
use strict;
use warnings;
use lib qw{../CNTI1409/lib/};
use Validador::Esquema;

my $dsn = "dbi:Pg:dbname=validador;host=192.168.56.101";
my $schema = Validador::Esquema->connect($dsn,"admin", "123321...");

my $id = shift;

my $auditoria =
  $schema->resultset('Auditoria')
  ->search( { id => $id }, { columns => [qw/url/] } )->first;

printf "%d\n", $auditoria->url_count();


1;
