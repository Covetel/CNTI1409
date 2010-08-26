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

use WWW::Mechanize::Cached;

my $cache = WWW::Mechanize::Cached->new;
$cache->env_proxy();
$cache->agent_alias("Linux Mozilla");

my $base = "http://www.cnti.gob.ve/";

sub get_url {
    my $url = shift;
    say STDERR "GET: $url";
    my $mech = $cache->clone;
    $mech->get($url);
    return $mech;
}

sub get_recursive {
    my ($url_list, $queue, $depth, $num, $dir) = @_;

    my @links = grep { index($_->url_abs, $_->base) >= 0 } @$url_list;
    #my @links = @$url_list;
    return unless @links;
    $_ = $_->url_abs for @links;
    given ( $dir ) {
        when ( $dir == 0 ) {
            @links = reverse @links;
        }
        when ( $dir == 1 ) {
            # random order
            for (my $i=@links; --$i; ) {
                my $j = int(rand($i));
                my $t = $links[$i];
                $links[$i] = $links[$j];
                $links[$j] = $t;
            }
        }
        when ( $dir == 2 )  {}
        default  { die }
    }
    my $n = $num;
    while ( @links ) {
        my $url = pop @links;
        next if exists $queue->{ $url };
        my $mech = get_url( $url );
        next unless $mech->success and $mech->status ~~ /^200/ and $mech->is_html;
say STDERR "SAVED: $url";
        $queue->{ $url } = $mech->title || $url;
        return unless --$n;
        if ( $depth > 0 ) {
            get_recursive( scalar($mech->links), $queue, $depth-1, $num, $dir );
        }
    }
}

sub spider {
    my ($url, $depth, $num, $dir ) = @_;

    $depth = 0 unless defined $depth;
    $num = 4 unless defined $num;
    $dir = 0 unless defined $dir;

    my $queue = {};

    my $mech = get_url( $url );
    return unless $mech->success and $mech->status ~~ /^200/ and $mech->is_html;
    $queue->{ $url } = $mech->title || $url;
    return $queue if $depth <= 0;

    get_recursive( scalar($mech->links), $queue, $depth-1, $num, $dir );
    return $queue;
}

use YAML;
my $q = spider( $base, 4, 9, 0 );
print YAML::Dump $q;
