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
$spider->run;
for ( $spider->queue ) {
    printf "%s %s\n", $_->sum, $_->title;
}
