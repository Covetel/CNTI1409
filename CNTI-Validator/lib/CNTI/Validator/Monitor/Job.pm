package CNTI::Validator::Monitor::Job;
use Moose;
use utf8;
use JSON::XS;

extends 'CNTI::Validator::Monitor::Base';
with 'CNTI::Validator::Monitor::Queued';

has site  => ( is => "ro" );
has cb    => ( is => "ro" );
has data  => ( is => "ro" );

sub model_class  {'CNTI::ValidatorDB::Result::Jobs'}
sub child_class  {'CNTI::Validator::Monitor::URL'}
sub parent_class { }

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Monitor::Job - Descripción de un evento en el validador

=head1 SYNOPSIS

    my $job = CNTI::Validator::Jobs->find_job( $some_job );
    printf "El job %d tiene estado %s\n", $job->id, $job->state;
    my $it = $job->children
    while ( my $u = $it->() ) {
        printf "URL: %s\n", $u->url;
    }

=head1 DESCRIPTION

Estructura para monitorear un trabajo de validación.

Extiende CNTI::Validator::Monitor::Base.

Implementa: CNTI::Validator::Monitor::Queued.

=head1 ATRIBUTOS

=head2 Públicos

=head3 id

=over 4

=item * 

Descripción: Identificador único de job.

=item *

Tipo de datos: Int

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 site

=over 4

=item * 

Descripción: el nombre del site que se está validando

=item *

Tipo de datos: Cadena de caracteres

=item *

Propiedades: Solo Lectura, Obligatorio

=back

=head3 cb

=over 4

=item * 

Descripción: el callback indicado en la creación del job.

=item *

Tipo de datos: Escalar (Estructura JSON)

=item *

Propiedades: Solo Lectura, Opcional

=back

=head3 data

=over 4

=item * 

Descripción: Información a enviar al callback (cb) cuando el job finalice.

=item *

Tipo de datos: Escalar (Estructura JSON)

=item *

Propiedades: Solo Lectura, Opcional

=back

=head3 state

=over 4

=item * 

Descripción: estado del job (new, run, done).

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

=head1 METODOS PÚBLICOS

=head2 refresh

Este método se hereda de CNTI::Validator::Monitor::Base.

Refresca los atributos que han cambiado en un objeto desde que fué
creado, por ejemplo si se desea verificar el estado (state) actual
se pude hacer:

    $obj->refresh
    printf "El estado actual del trabajo es: %s\n", $obj->state

=head2 children

Este método se hereda de CNTI::Validator::Monitor::Base.

Obtiene un iterador que permite recorrer los hijos del trabajo, 
el iterador devuelto es un clausura que se invoca sin argumentos
y retorna elementos de la clase CNTI::Validator::Monitor::URL.

    printf "Los URLs asociados al job %d\n", $job->id
    my $it = $job->children
    while ( my $u = $it->() ) {
        printf "URL: %s\n", $u->url;
    }

=head2 add_children( @lista_de_caminos )

Este método se hereda de CNTI::Validator::Monitor::Base.

Agrega la @lista_de_caminos al objeto, cada camino es una cadena de
caracteres que se convertirá internamente a objetos de tipo 
CNTI::Validator::Monitor::URL.

    $obj->add_children( "/principal", "/contacto", "/institucion" )

=head2 parent

Este método retorna undef.

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
