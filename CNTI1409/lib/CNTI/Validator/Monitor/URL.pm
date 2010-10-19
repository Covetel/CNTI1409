package CNTI::Validator::Monitor::URL;
use Moose;
use utf8;
use URI;

extends 'CNTI::Validator::Monitor::Base';
with 'CNTI::Validator::Monitor::Queued';

has id    => ( is => "ro" );
has path  => ( is => "ro" );

sub model_class  {'CNTI::ValidatorDB::Result::Urls'}
sub child_class  {'CNTI::Validator::Monitor::Result'}
sub parent_class {'CNTI::Validator::Monitor::Job'}

sub uri {
    my $self = shift;
    return URI->new_abs( $self->path, $self->parent->site );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::URL - Descripción de un URL en el validador

=head1 SYNOPSIS

    my $job = CNTI::Validator::Jobs->find_job( $some_job );
    printf "El job %d tiene estado %s\n", $job->id, $job->state;
    my $it = $job->children
    while ( my $u = $it->() ) {
        printf "URL: %s\n", $u->url;
    }

=head1 DESCRIPTION

Estructura para monitorear un url de un trabajo de validación.

Extiende CNTI::Validator::Monitor::Base.

Implementa: CNTI::Validator::Monitor::Queued.

=head1 ATRIBUTOS

=head2 Públicos

=head3 id

=over 4

=item * 

Descripción: Identificador único de url.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 path

=over 4

=item * 

Descripción: cadena que indica el camino dentro del site

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 state

=over 4

=item * 

Descripción: estado del url (new, run, done).

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

=head1 METODOS DE CLASE

=head2 model_class

La clase de DBIx::Class que se utiliza como modelo para esta.

=head2 child_class

La clase de monitoreo para los objetos hijos.

=head1 parent_class

La clase para el objeto padre

=head1 METODOS PÚBLICOS

=head2 uri

Retorna el un objeto URI con dirección absoluta del objeto.

=head2 refresh

Este método es mezclado por CNTI::Validator::Monitor::Queued.

Refresca los atributos que han cambiado en un objeto desde que fué
creado, por ejemplo si se desea verificar el estado (state) actual
se pude hacer:

    $obj->refresh
    printf "El estado actual del url es: %s\n", $obj->state

=head2 children

Este método se hereda de CNTI::Validator::Monitor::Base.

Obtiene un iterador que permite recorrer los hijos del trabajo, 
el iterador devuelto es un clausura que se invoca sin argumentos
y retorna elementos de la clase CNTI::Validator::Monitor::URL.

    printf "Los Reultados para el url %s\n", $obj->uri
    my $it = $job->children;
    while ( my $r = $it->() ) {
        printf "Resultado: para %s: %s\n", $r->name, $r->pass;
    }

=head2 add_children( @lista_de_resultados )

Este método se hereda de CNTI::Validator::Monitor::Base.

Agrega la @lista_de_resultados al objeto, cada camino es un hash con
los atributos apropiados para crear objetos del tipo
CNTI::Validator::Monitor::Resultado

    $obj->add_children( $r1, $r2, $r3 )

=head2 parent

Este método retorna el job al que pertenece este URL.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validator::Monitor::Base>,
L<CNTI::Validator::Monitor::Queued>,
L<CNTI::Validator::Monitor::Job>,
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
