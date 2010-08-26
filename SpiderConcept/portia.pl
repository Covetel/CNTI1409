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

package AracniState;
use Moose;

has num => ( is => "rw", isa => "Int", default => 0 );
has dir => ( is => "rw", isa => "Int", default => 0 );
has depth => (
    is      => "rw",
    isa     => "Int",
    default => 0,
    traits  => ["Counter"],
    handles => { depth_dec => "dec", depth_inc => "inc" }
);
has queue => (
    is      => "ro",
    isa     => "HashRef[Str]",
    default => sub { {} },
    traits  => ["Hash"],
    handles =>
        { queue_get => "get", queue_set => "set", queue_exists => "exists" }
);

__PACKAGE__->meta->make_immutable;
no Moose;

package AracniUrlList;
use Moose;
use URI::URL;

has dir => ( is => "rw", isa => "Int", default => 0 );
has list => (
    is      => "ro",
    isa     => "ArrayRef[WWW::Mechanize::Link]",
    traits  => ["Array"],
    handles => {
        list_pop   => "pop",
        list_shift => "shift",
        list_count => "count",
        list_get   => "get"
    }
);

sub BUILDARGS {
    my ( $class, %args ) = @_;
    my @links = grep { index( $_->url_abs, $_->base ) >= 0 } @{ $args{'list'} };
    my $dir = $args{'dir'} || 0;
    die "Invalid direction" if 0 > $dir || $dir > 2;
    @links = sort { rand(10) > 5 } @links if $dir == 1;
    return { list => \@links, dir => $dir };
}

sub list_next {
    my $self = shift;
    return $self->dir ? $self->list_pop : $self->list_shift;
}

sub list_look { shift->list_get(0) }

__PACKAGE__->meta->make_immutable;
no Moose;

package main;
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
    my ( $urls, $state ) = @_;

    my $n = $state->num;
    while ( $urls->list_count ) {
        my $url = $urls->list_next->url_abs;
        next if $state->queue_exists($url);
        my $mech = get_url($url);
        next
            unless $mech->success
                and $mech->status ~~ /^200/
                and $mech->is_html;
        printf STDERR "SAVED %d, %d: $url", $state->depth, $n;
        $state->queue_set( $url => $mech->title || $url );
        return unless --$n;

        if ( $state->depth > 0 ) {
            my $l = AracniUrlList->new(
                list => scalar( $mech->links ),
                dir  => $state->dir
            );
            $state->depth_dec;
            get_recursive( $l, $state );
            $state->depth_inc;
        }
    }
}

sub spider {
    my ( $url, $state ) = @_;

    my $queue = {};

    my $mech = get_url($url);
    return
        unless $mech->success
            and $mech->status ~~ /^200/
            and $mech->is_html;
    $queue->{$url} = $mech->title || $url;
    return if $state->depth <= 0;
    my $list = AracniUrlList->new(
        list => scalar( $mech->links ),
        dir  => $state->dir
    );

    get_recursive( $list, $state );
    return $queue;
}

use YAML;
my $state = AracniState->new( depth => 4, num => 9, dir => 0 );
my $q = spider( $base, $state );
print YAML::Dump $q;
