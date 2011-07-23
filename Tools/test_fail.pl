#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use lib qw{../CNTI1409/lib/};
use Validador::Esquema;
my $dsn = "dbi:Pg:dbname=validador;host=192.168.56.101";
my $schema = Validador::Esquema->connect($dsn,"admin", "123321...");

my $id = shift;
my $name = shift;

my $idjob = $schema->resultset('Auditoria')->find($id)->job;

my @urls = $schema->resultset('ResultadosDisposicion')->search({name =>
        $name},{ bind => [$idjob]} );


for (@urls){
    state $sum = 0; 
    $sum++;
    printf "%d: %s: %s: %s Mensaje: %s\n", $sum, $_->name,  $_->pass, $_->path, $_->message;
    if ($_->paso && !$_->fail && !$_->fallo){
        print "Paso\n";
    } else {
        print "Fallo\n";
    }
}

if ($schema->resultset('ResultadosDisposicion')->fallo($idjob, $name)){
    print "Resultado General: Falló\n";
} else {
    print "Resultado General: Pasó\n";
}

if ($schema->resultset('ResultadosDisposicion')->fail($idjob, $name)){
    print "Resultado General: Falló\n";
} else {
    print "Resultado General: Pasó\n";
}

if ($schema->resultset('ResultadosDisposicion')->paso($idjob, $name)){
    print "Resultado General: Paso\n";
} else {
    print "Resultado General: Fallo\n";
}

if ($schema->resultset('ResultadosDisposicion')->pass($idjob, $name)){
    print "Resultado General: Paso\n";
} else {
    print "Resultado General: Fallo\n";
}

1;
