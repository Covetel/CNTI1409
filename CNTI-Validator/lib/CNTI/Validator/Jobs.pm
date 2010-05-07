package CNTI::Validator::Jobs;
use strict;
use utf8;

use CNTI::Validator::Schema;

# Todos estos deberían ser componentes cargados dinámicamente peeero ...
use CNTI::Validator::Monitor::Job;
use CNTI::Validator::Monitor::URL;
use CNTI::Validator::Monitor::Result;
use CNTI::Validator::Monitor::Event;

use common::sense;
use POSIX qw(strftime);

sub new_job {
    my $self = shift;
    my %args = @_;

    my $missing = join ", ", grep { !exists $args{$_} } qw(site sample);
    die "Missing fields: $missing" if $missing;

    my %sample = map { $_ => 1 } @{ delete $args{'sample'} };
    $sample{"/"} = 1 unless exists $sample{"/"};

    my %record;
    for my $field (qw(site callback data)) {
        $record{$field} = delete $args{$field} if exists $args{$field};
    }
    my $unknown = join ", ", keys %args;
    die "Unknown fields: $unknown" if $unknown;

    $record{'data'}  = $record{'data'};
    $record{'state'} = 'new';
    $record{'ctime'} = strftime( "%F %T", localtime time );
    $record{'mtime'} = $record{'ctime'};

    $record{'children'} = [
        map {
            {   path  => $_,
                state => "new",
                ctime => $record{'ctime'},
                mtime => $record{'ctime'},
            }
            } sort keys %sample
    ];

    CNTI::Validator::Monitor::Job->hash_new( \%record );
}

sub find_job {
    my $self = shift;
    my $id   = shift;

    # Buscar el job
    my $job = CNTI::Validator::Schema->resultset('Jobs')->find($id);
    return undef unless $job;
    return CNTI::Validator::Monitor::Job->new($job);
}

sub search_jobs {
    my $self = shift;

    my $rs = CNTI::Validator::Schema->resultset('Jobs')->search(@_);
    return sub { CNTI::Validator::Monitor::Job->new( $rs->next ) };
}

sub cancel_job {
    my $self = shift;
    my $id   = shift;
    my $job  = $self->find_job($id);
    $job->set_state('cancel');
    my $it = $job->children();
    while ( my $u = $it->() ) {
        if ( $u->state ~~ [qw(new open)] ) {
            $u->set_state('cancel');
        }
    }
}

sub delete_job {
    my $self = shift;
    my $id   = shift;
    my $job  = $self->find_job($id);
    $job->set_state('cancel');
    my $it = $job->children();
    while ( my $url = $it->() ) {
        my $u_it = $url->children;
        while ( my $result = $u_it->() ) {
            my $r_it = $result->children;
            while ( my $event = $r_it->() ) {
                $event->_rec->delete;
            }
            $result->_rec->delete;
        }
        $url->_rec->delete;
    }
    $job->_rec->delete;
}

sub get_next_new_job {
    my $self = shift;
    my $it = $self->search_jobs( { state => "new" }, { order_by => 'ctime' } );
    return $it->();
}

1;

__END__

=encoding utf8

=head1 NAME

CNTI::Validator::Jobs - Control de la cola de Jobs en el validador

=head1 SYNOPSIS

    my $job = CNTI::Validador::Jobs->new_job(
        site => "http://www.mppef.gob.ve",
        sample => [
            "/mision",
            "/vision",
            "/objetivos",
            ],
        callback => "http://validador.gob.ve/mi-callback",
        data => { algo => 1, mas => 2 }
    );

    my $job = CNTI::Validador::Jobs->find_job( $some_job );

    my $it = CNTI::Validador::Jobs->search_job( { state => "done" } );
    while ( my $job = $it->() ) {
        printf "El job %d está listo\n", $job->id;
    }

=head1 DESCRIPTION

Maneja la cola de trabajos de validación.

=head1 METODOS DE CLASE

=head2 new_job

Crea un nuevo trabajo de validación y retorna un monitor de job, recibe
atributos por nombre.

Los atributos site y sample son obligatorios.

El atributo site debe ser el el URL completo de un portar a verificar.

El atributo sample es una lista de caminos a verificar dentro del portal
y no hace falta especificar la raíz porque se agrega automáticamente si
no se especifica.

El atributo callback es el URL completo de una dirección que se visitará
cuando la job haya finalizado o abortado, esta dirección se visitará con
el método GET de HTTP, a menos que se utilice el atributo data, en cuyo
caso la estructura de datos se pasará serializada en JSON como cuerpo de
un POST al url de callback.

El valor de retorno sera un monitor de job es decir un objeto de tipo
CNTI::Validador::Monitor::Job.

=head2 find_job( $id )

Busca un trabajo de validación en la cola y devuelve un monitor de job.

Recibe como argumento el id del job.

=head2 search_jobs( $condicion )

Busca un conjunto de trabajos de validación en la cola y devuelve un 
iterador a los mismos.

El iterador retorna los monitores de job de cada trabajo encontrado o
undef al final de la lista

=head2 cancel_job( $id )

Cancela un trabajo de validación.

Recibe como argumento el id del job.

=head2 delete_job( $id )

Elimina un trabajo de validación.

Recibe como argumento el id del job.

=head1 CAVEATS AND NOTES

none yet

=head1 HISTORY

José Rey mié may  5 06:59:19 VET 2010 versión inicial

=head1 SEE ALSO

L<CNTI::Validador::Monitor::Job>

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
