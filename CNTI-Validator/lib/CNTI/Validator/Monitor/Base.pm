package CNTI::Validator::Monitor::Base;
use Moose;
use JSON::XS;

has _rec => ( is => "ro", required => 1 );
has pid => ( is => "ro", isa => "Maybe[Int]" );
has id  => ( is => "ro", isa => "Maybe[Int]" );

around BUILDARGS => sub {
    my $orig   = shift;
    my $class  = shift;
    my $record = shift;
    $class->$orig( $record->get_columns, _rec => $record );
};

sub children {
    my $self = shift;

    # get the child class or return a dummy iterator
    my $childc = $self->child_class || return undef;

    # make a recordset to be closured in iterator
    my $rs = $self->_rec->search_related( $childc->model_class->table, @_ );

    # Making a proper Moose iterator will take some time so ...
    return sub {
        my $next = $rs->next;
        return undef unless $next;
        $self->child_class->new($next);
    };
}

sub add_children {
    my $self   = shift;
    my $rec    = $self->_rec;
    my $childc = $self->child_class || die ref($self) . " does not allow children";
    my $childt = $childc->model_class->table;
    map { $childc->new( $rec->create_related( $childt, $_ ) ) } @_;
}

sub add_child {
    my $self   = shift;
    my $rec    = $self->_rec;
    my $childc = $self->child_class || die ref($self) . " does not allow children";
    my $childt = $childc->model_class->table;
    $childc->new( $rec->create_related( $childt, shift ) );
}

sub parent {
    my $self = shift;
    my $pid  = $self->_rec->pid;
    return undef unless $pid;
    return $self->parent_class->new( $pid );
}

sub pretty {
    my $self   = shift;
    my $depth  = shift;
    my $level  = shift || 0;
    my %fields = $self->_rec->get_columns;
    my @fields;
    my $out = '';
    my $len = 0;
    for ( sort keys %fields ) {
        next unless exists $fields{$_} and defined $fields{$_};
        push @fields, [ $_ => $fields{$_} ];
        $len = length $_ if $len < length $_;
    }
    my $ind = "    " x $level;
    $out .= sprintf("$ind%-${len}s: %s\n", @$_) for @fields;
    my $pos = 0;
    if ( !defined($depth) || $depth-- ) {
        my $it = $self->children;
        if ($it) {
            my @children;
            while ( my $ch = $it->() ) {
                push @children, $ch->pretty( $depth, $level+1 );
            }
            $out .= sprintf("$ind%${len}s [%d]:\n%s", $self->child_class, $pos++, $_) for @children;
        }
    }
    return $out;
}

sub as_hash {
    my $self   = shift;
    my $depth  = shift;
    my %fields = $self->_rec->get_columns;
    if ( !defined($depth) || $depth-- ) {
        my $it = $self->children;
        if ($it) {
            my @children;
            while ( my $ch = $it->() ) {
                push @children, $ch->as_hash( $depth );
            }
            $fields{'children'} = \@children if @children;
        }
    }
    return \%fields;
}

sub as_json {
    my $self = shift;
    my $depth = shift;
    my $hash = $self->as_hash($depth);
    for ( values %$hash ) {
        $_ = encode_json($_) if ref $_;
    }
    encode_json( $self->as_hash );
}

sub hash_new {
    my $self     = shift;
    my $data     = shift;
    my $children = delete $data->{'children'};
    for ( values %$data ) {
        $_ = encode_json($_) if ref $_;
    }
    my $rec = CNTI::Validator::Schema->resultset( $self->model_class )->create($data);
    my $obj = $self->new($rec);
    my $childc = $self->child_class || die ref($self) . " does not allow children";
    for my $ch ( @$children) {
        $ch->{'pid'} = $obj->id;
        $childc->hash_new( $ch );
    }
    return $obj;
}

sub json_new {
    my $self = shift;
    $self->from_hash( decode_json(shift) );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::Base - Clase base de los objetos de monitoreo

=head1 SYNOPSIS

    package CNTI::Validator::Monitor::Objeto
    use Moose;

    extends 'CNTI::Validator::Monitor::Base'

    ...

=head1 DESCRIPTION

El objeto de esta clase es proveer una infraestructura común para la
serializacióny persistencia de todos los objetos de monitoreo.

En la actualidad se utiliza DBIx::Class como base para persistencia
de los objetos y JSON como sistema de serialización de los mismos.

=head1 ATRIBUTOS

=head2 Públicos

=head3 id

=over 4

=item * 

Descripción: Identificador de objeto para la capa de persistencia.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 parent

=over 4

=item * 

Descripción: Identificador del objeto padre para la capa de persistencia.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head2 Privados

=head3 _rec

=over 4

=item * 

Descripción: datos del objeto representados en la capa de persistencia.

=item *

Tipo de datos: DBIx::Class::Row

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head1 METODOS PÚBLICOS

=head2 refresh

Refresca los atributos que han cambiado en un objeto desde que fué
creado, por ejemplo si se desea verificar el estado (state) actual
se pude hacer:

    $obj->refresh

=head2 children

Obtiene un iterador que permite recorrer los hijos de un objeto,
el iterador será un clausura que se invoca sin argumentos
y retorna un hijo cada vez que se invoca.

    my $it = $obj->children
    while ( my $h = $it->() ) {
        printf "Hijo: %s\n", $h->id;
    }

En el caso de objetos que no permitan hijos, el método devuelve undef

=head2 add_children( @lista )

Agrega la @lista de propiedades al objeto, cada elemento debe ser del
tipo apropiado para crear hijos de un objeto específico.

    $obj->add_children( $hijo1, $hijo2, $hijo3 )

=head2 parent

Este método el padre de un objeto o undef si el objeto no tiene ningún
padre.

=head2 as_hash( $depth )

Retorna un hash con los atributos del objeto y todos sus descendientes.

El argumento opcional $depth indica con cuanta profundidad se desea
obtener el objeto, si se omite (o es cero) solo se retorna el objeto
actual, si es 1 se retorna el objeto actual y sus hijos, si es 2 se
incluyen los nietos, etc.

=head2 as_json( $depth )

Retorna el objeto serializado como JSON

El argumento opcional $depth indica con cuanta profundidad se desea
obtener el objeto, si se omite (o es cero) solo se retorna el objeto
actual, si es 1 se retorna el objeto actual y sus hijos, si es 2 se
incluyen los nietos, etc.

=head2 hash_new

Crea un nuevo objeto basado en un hash, si el objeto incluye descendientes
especificados en clave children, estos también se crearán recursivamente.

=head2 json_new

Crea un nuevo objeto a partir de una cadena JSON, si el objeto incluye
descendientes especificados en clave children, estos también se crearán
recursivamente.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validator::Monitor::Job>,
L<CNTI::Validator::Monitor::URL>,
L<CNTI::Validator::Monitor::Result>,
L<CNTI::Validator::Monitor::Event>

=head1 AUTHOR

José Luis Rey <reyjose@covetel.com.ve>

=head1 BUGS

Todo el software de cieta complejidad puede contener errores, si consigues
algún error en este código por favor reportalo a: L<mailto:ifo@covetel.com.ve>

Nos sería de mucha ayuda si además de reportar el error puedes hacer un caso
de prueba que identifique el problema y adjuntarlo al reporte del error.

=head1 SOURCE

Las fuentes de este programa se encuentran disponibles en un repositorio Git
ubicado en L<http://git.covetel.com.ve/CNTI-14-09.git>

=head1 COPYRIGHT

Copyright 2010 by CNTI <info@cnti.gob.ve>

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

Este programa es software libre; lo puedes redistribuir y modificar en los
mismos términos que las fuentes de Perl.

=cut
#
# vim: ts=4 sw=4 expandtab
#
