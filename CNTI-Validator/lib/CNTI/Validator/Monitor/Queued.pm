package CNTI::Validator::Monitor::Queued;
use Moose::Role;
use utf8;
use POSIX qw(strftime);

has state => ( is => "ro" );
has ctime => ( is => "ro" );
has mtime => ( is => "ro" );

sub set_state {
    my $self = shift;
    my $args = { state => shift };
    $args->{'proc'} = shift || $$;
    $args->{'mtime'} = strftime( "%F %T", localtime time );
    $self->_rec->update( $args );
    $self->refresh;
}

sub refresh {
    my $self = shift;
    my $rec  = $self->_rec;
    $rec->discard_changes();

    my %cols = $rec->get_columns;
    while ( my ($name, $value) = each %cols ) {
        # interface violation but quick :-) XXX
        $self->{$name} = $value;
    }
}

1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::Queued - Rol para objetos encolables

=head1 SYNOPSIS

    package CNTI::Validator::Monitor::Objeto;
    use Moose;
    with 'CNTI::Validator::Monitor::Queued';

    ...

=head1 DESCRIPTION

Rol que permite hacer un objeto encolable.

=head1 ATRIBUTOS

=head2 Públicos

=head3 state

=over 4

=item * 

Descripción: estado del objeto.

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Opcional

=back

=head3 proc

=over 4

=item * 

Descripción: Proceso que está utilizando el objeto.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Opcional

=back

=head3 ctime

=over 4

=item * 

Descripción: fecha de creación.

=item *

Tipo de datos: Fecha

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 mtime

=over 4

=item * 

Descripción: fecha de modificación.

=item *

Tipo de datos: Fecha

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head1 METHODS

=head2 refresh

Refresca los atributos que han cambiado en un objeto desde que fué
creado, por ejemplo si se desea verificar el estado (state) actual
se pude hacer:

    $obj->refresh

=head2 set_state( $state [, $pid ] )

Cambia el estado del elemento a $state y cambia el id del proceso
que efectuó el cambio, si no se especifica el $pid, se utilizará 
el pid del proceso actual ($$)

Como cualquier otra modificación del objeto, esta operación cambia
la fecha de modificación (mtime) del mismo.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validator::Monitor::Base>,
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
