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

has depth => ( is => "rw", isa => "Int", default => 0 );
has num   => ( is => "rw", isa => "Int", default => 0 );
has dir   => ( is => "rw", isa => "Int", default => 0 );
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
    isa     => "ArrayRef[URI::URL]",
    traits  => ["Array"],
    handles => {
        list_pop   => "pop",
        list_shift => "shift",
        list_count => "count",
        list_get   => "get"
    }
);

sub BUILDARGS {
    my ( $class, $list, $dir ) = @_;
    my @links = grep { index( $_->url_abs, $_->base ) >= 0 } @$list;
    $dir ||= 0;
    die "Invalid direction" if 0 > $dir || $dir > 2;
    @links = sort { rand(10) > 5 } @links if $dir == 1;
    return { list => \@links, dir => $dir };
}

sub next {
    my $self = shift;
    return $self->dir ? $self->list_pop : $self->list_shift;
}

sub look { shift->list_get(0) }

__PACKAGE__->meta->make_immutable;
no Moose;

package main;
use WWW::Mechanize::Cached;

my $cache = WWW::Mechanize::Cached->new;
$cache->env_proxy();
$cache->agent_alias("Linux Mozilla");

my $base = "http://www.mppef.gob.ve/";

sub get_url {
    my $url = shift;
    say STDERR "GET: $url";
    my $mech = $cache->clone;
    $mech->get($url);
    return $mech;
}

sub get_recursive {
    my ( $url_list, $queue, $depth, $num, $dir ) = @_;

    my @links = grep { index( $_->url_abs, $_->base ) >= 0 } @$url_list;

    #my @links = @$url_list;
    return unless @links;
    $_ = $_->url_abs for @links;
    given ($dir) {
        when ( $dir == 0 ) {
            @links = reverse @links;
        }
        when ( $dir == 1 ) {

            # random order
            for ( my $i = @links; --$i; ) {
                my $j = int( rand($i) );
                my $t = $links[$i];
                $links[$i] = $links[$j];
                $links[$j] = $t;
            }
        }
        when ( $dir == 2 ) { }
        default            {die}
    }
    my $n = $num;
    while (@links) {
        my $url = pop @links;
        next if exists $queue->{$url};
        my $mech = get_url($url);
        next
            unless $mech->success
                and $mech->status ~~ /^200/
                and $mech->is_html;
        say STDERR "SAVED: $url";
        $queue->{$url} = $mech->title || $url;
        return unless --$n;
        if ( $depth > 0 ) {
            get_recursive( scalar( $mech->links ),
                $queue, $depth - 1, $num, $dir );
        }
    }
}

sub spider {
    my ( $url, $depth, $num, $dir ) = @_;

    $depth = 0 unless defined $depth;
    $num   = 4 unless defined $num;
    $dir   = 0 unless defined $dir;

    my $queue = {};

    my $mech = get_url($url);
    return
        unless $mech->success
            and $mech->status ~~ /^200/
            and $mech->is_html;
    $queue->{$url} = $mech->title || $url;
    return $queue if $depth <= 0;

    get_recursive( scalar( $mech->links ), $queue, $depth - 1, $num, $dir );
    return $queue;
}

use YAML;
my $q = spider( $base, 4, 9, 0 );
print YAML::Dump $q;
