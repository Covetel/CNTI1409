use feature ":5.10";
use strict;

package AracniState;
use Moose;

# num: número de hijos para cada nodo
# dir: dirección para adquirir los hijos
# depth: niveles de profundidad 0 => solo el URL actual
# queue: cola con todos los urls recolectados

has base => ( is => "ro", isa => "Str", required => 1 );
has num  => ( is => "rw", isa => "Int", default  => 0 );
has dir  => ( is => "rw", isa => "Int", default  => 0 );
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


sub run {
    my $self = shift;
    $self->url_get( $self->base, $self->depth );
}


sub url_get {
    my ( $self, $url, $depth ) = @_;

    my $mech = AracniUA->new();
    $mech->safe_get($url) or return;
    printf STDERR "SAVED %d: $url\n", $depth;

    # Moose says $url must be string!
    $self->queue_set( "$url" => $mech->title || "$url" );

    if ( $depth > 0 ) {
        my @links = $mech->links;
        if (@links) {
            my $l = AracniUrlList->new(
                list => \@links,
                dir  => $self->dir
            );
            $self->add_hyperlinks( $l, $depth - 1 );
        }
    }
}

sub add_hyperlinks {
    my ( $self, $urls, $depth ) = @_;

    my $n = $self->num;
    while ( --$n && $urls->list_count ) {
        my $url = $urls->list_next->url_abs;
        next if $self->queue_exists($url);
        $self->url_get( $url, $depth );
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
