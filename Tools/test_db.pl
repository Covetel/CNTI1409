#!/usr/bin/env perl
use strict;
use warnings;
use lib qw{../CNTI1409/lib/};
use Validador::Esquema;

my $dsn = "dbi:Pg:dbname=validador;host=192.168.5.126";
my $schema = Validador::Esquema->connect($dsn,"admin", "123321...");

my $id = shift;

$a = $schema->resultset('Auditoria')->find($id);
my $j = $schema->resultset('Job')->find($a->job);

if ($j){
 print "Urls Terminadas: ", $j->urls_done, "\n";
 print "Urls Pendientes: ", $j->urls_new, "\n";
 print "Total : " , $j->urls_total, "\n";

 print "Trabajando en: ",  $j->path_run, "\n";

}

1;
