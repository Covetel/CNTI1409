use utf8;
use feature ":5.10";
use strict;

package AracniUrlList;
use Moose;
use URI::URL;

# dir: dirección en la que se recorre la lista
#   0: izquierda a derecha
#   1: aleatoriamente
#   2: derecha a izquierda
#
# list: lista de enlaces
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
    my @links
        = grep { index( $_->url_abs, $_->base ) >= 0 } @{ $args{'list'} };
    my $dir = $args{'dir'} || 0;
    
    # La dirección debe estar entre 0 y 2
    die "Invalid direction" if 0 > $dir || $dir > 2;

    # Barajar los enlaces en caso de que $dir == 1
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
1;
