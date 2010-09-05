#!/usr/bin/env perl

# Prototipo de araña, por ahora mantiene el estado en memoria.
#
# Se utilizó DFS en preorden para minimizar el uso de RAM.
#
# Supongo que cuando se quiera monitorear el termometro
# saltará igual que en Windows, aunque ya veremos.
#
# Arthropoda/Arachnida/Araneae/Salticidae/Spartaeinae/Spartaeini/Portia
#
use utf8;
use feature ":5.10";
use strict;

use CNTI::Spider::UA;
use CNTI::Spider::State;
use CNTI::Spider::UrlList;

my $base = "http://www.cnti.gob.ve/";

use YAML;
my $spider = CNTI::Spider::State->new( base => $base, depth => 4, num => 20, dir => 0 );

# Arrancar un hijo en paralelo
if ( $spider->run ) {
    # El padre puede monitorear al hijo, creando un objeto con id
    my $monitor = CNTI::Spider::State->new( id => $spider->id );
    
    #  mientras el estado sea diferente de done
    while ( $monitor->state < 2 ) {
        printf "Child working %d %d\n", $monitor->id, $monitor->state;
        sleep 1;

        # refrescar el registro
        $monitor->discard_changes;
    }
}
else {
    # Ej hijo nunca regresa del metodo run, asi que esto no debería ejecutarse
    die "Child returned!!!!!!!!!!!!!!\n"
}

sub printq {
    for ( $spider->queue ) {
        printf "%s %s\n", $_->sum, $_->title;
    }
}
