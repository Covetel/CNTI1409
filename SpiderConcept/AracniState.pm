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

__PACKAGE__->meta->make_immutable;
no Moose;
1;
