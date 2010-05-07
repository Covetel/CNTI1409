package CNTI::Validator::Monitor::Queued;
use Moose::Role;
use utf8;

has state => ( is => "ro" );
has ctime => ( is => "ro" );
has mtime => ( is => "ro" );

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
