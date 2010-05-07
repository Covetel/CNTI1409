package CNTI::Validator::Monitor::Event;
use Moose;
use utf8;

extends 'CNTI::Validator::Monitor::Base';

has class   => ( is => "ro" );
has message => ( is => "ro" );
has data    => ( is => "ro" );

sub model_class  {'CNTI::ValidatorDB::Result::Events'}
sub parent_class {'CNTI::Validator::Monitor::Result'}
sub child_class  {  }

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::Event - Descripción de un evento en el validador

=head1 SYNOPSIS

    print "Eventos de la prueba %s:", $result->name
    my $it = $result->children
    while ( my $e = $it->() ) {
        printf "%s: %s\n", $e->class, $e->message;
    }

=head1 DESCRIPTION

Crea una estructura para describir un evento.

Extiende CNTI::Validator::Monitor::Base.

=head1 ATRIBUTOS

=head2 Públicos

=head3 class

=over 4

=item * 

Descripción: Clase de evento, por ejemplo "error", "warning", "fatal", etc.

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 mesg 

=over 4

=item * 

Descripción: Mensaje o descripción del evento.

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 data

=over 4

=item * 

Descripción: Cualquier otra información que se quiera asociar al evento.

=item *

Tipo de datos: Escalar

=item *

Propiedades: Solo Lectura, Opcional

=back

=head1 METODOS DE CLASE

=head2 model_class

La clase de DBIx::Class que se utiliza como modelo para esta.

=head2 child_class

La clase de monitoreo para los objetos hijos.

=head parent_class

La clase para el objeto padre

=head1 METODOS PÚBLICOS

=head2 children

Este método se hereda de CNTI::Validator::Monitor::Base, pero los
objetos de este tipo no tienen hijos así que su invocación
retorna undef.
    
=head2 add_children

Este método se hereda de CNTI::Validator::Monitor::Base, pero los
objetos de este tipo no tienen hijos así que su invocación
genera una excepción.
    
=head2 parent

Este método retorna el resultado al que aplica este evento.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validator::Monitor::Base>,
L<CNTI::Validator::Monitor::Job>,
L<CNTI::Validator::Monitor::URL>,
L<CNTI::Validator::Monitor::Result>

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
