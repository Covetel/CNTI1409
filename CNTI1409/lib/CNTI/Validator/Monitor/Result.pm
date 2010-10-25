package CNTI::Validator::Monitor::Result;
use Moose;
use utf8;

extends 'CNTI::Validator::Monitor::Base';

has name => ( is => "ro" );
has pass => ( is => "ro" );

sub model_class  {'CNTI::ValidatorDB::Result::Results'}
sub child_class  {'CNTI::Validator::Monitor::Event'}
sub parent_class {'CNTI::Validator::Monitor::URL'}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::Result - Descripción de un resultado en el validador

=head1 SYNOPSIS

    my $it = $url->children
    while ( my $r = $it->() ) {
        printf "Resultado de %s: %s\n", $r->name, $r->pass;
    }

=head1 DESCRIPTION

Estructura para monitorear un resultado de un trabajo de validación.

Extiende CNTI::Validator::Monitor::Base.

=head1 ATRIBUTOS

=head2 Públicos

=head3 id

=over 4

=item * 

Descripción: Identificador único de resultado.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 name

=over 4

=item * 

Descripción: Nombre de la prueba

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 pass

=over 4

=item * 

Descripción: estado de la prueba (fail, pass, dubious, abort).

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Opcional

=back

=head3 data

=head1 METODOS DE CLASE

=head2 model_class

La clase de DBIx::Class que se utiliza como modelo para esta.

=head2 child_class

La clase de monitoreo para los objetos hijos.

=head1 parent_class

La clase para el objeto padre

=head1 METODOS PÚBLICOS

=head2 children

Este método se hereda de CNTI::Validator::Monitor::Base.

Obtiene un iterador que permite recorrer los hijos del trabajo, 
el iterador devuelto es un clausura que se invoca sin argumentos
y retorna elementos de la clase CNTI::Validator::Monitor::Event.

    printf "Los eventos asociados al resultado %d\n", $res->id
    my $it = $res->children
    while ( my $e = $it->() ) {
        printf "%s: %s\n", $r->class, $r->mesg;
    }

=head2 add_children( @lista_de_eventos )

Este método se hereda de CNTI::Validator::Monitor::Base.

Agrega la @lista_de_eventos al objeto, cada evento es un hash con
los atributos apropiados para crear objetos del tipo
CNTI::Validator::Monitor::Event

    $obj->add_children( $r1, $r2, $r3 )
    
=head2 parent

Este método retorna el URL al que aplica este resultado.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validator::Monitor::Base>,
L<CNTI::Validator::Monitor::Job>,
L<CNTI::Validator::Monitor::URL>,
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
