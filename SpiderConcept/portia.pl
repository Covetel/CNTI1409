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
use feature ":5.10";
use strict;

use AracniUA;
use AracniState;
use AracniUrlList;

my $base = "http://www.cnti.gob.ve/";

sub spider {
    my $state = shift;
    get_url_recursive( $state->base, $state, $state->depth );
}

sub get_url_recursive {
    my ( $url, $state, $depth ) = @_;

    my $mech = AracniUA->new();
    $mech->get($url) or next;
    printf STDERR "SAVED %d: $url", $depth;

    # Moose says $url must be string!
    $state->queue_set( "$url" => $mech->title || "$url" );

    if ( $depth > 0 ) {
        my @links = $mech->links;
        if (@links) {
            my $l = AracniUrlList->new(
                list => \@links,
                dir  => $state->dir
            );
            get_links_recursive( $l, $state, $depth - 1 );
        }
    }
}

sub get_links_recursive {
    my ( $urls, $state, $depth ) = @_;

    my $n = $state->num;
    while ( --$n && $urls->list_count ) {
        my $url = $urls->list_next->url_abs;
        next if $state->queue_exists($url);
        get_url_recursive( $url, $state, $depth );
    }
}

use YAML;
my $state = AracniState->new( base => $base, depth => 4, num => 9, dir => 0 );
my $q = spider( $state );
print YAML::Dump $q;
