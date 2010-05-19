package CNTI1409::Controller::Reportes;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

CNTI1409::Controller::Reportes - Catalyst Controller

=head1 DESCRIPTION

Esta controladora es responsable de generar todos los reportes del sistema.

=head1 METHODS

=cut


=head2 index

En un futuro, el método index, va a construir un wizard para generar reportes.

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

=head2 disposiciones($job_id)

Devuelve un hash con las disposiciones de un job.

=cut

sub disposiciones {
    my ( $job_id ) = @_; 
    my $j = CNTI::Validator::Jobs->find_job($job_id);
	my $site = $j->site;
    my $it = $j->children;
    my $disp = {}; 
    while ( my $u = $it->() ) { 
        my $it2 = $u->children;
        while (my $r = $it2->()){
            $disp->{$r->name}->{result} = 'pass';
            $disp->{$r->name}->{name} = $r->name;
            my $url = $site . $u->path; 
            $url =~ s/\s//gi;
            $url =~ s/\r//gi;
            $disp->{$r->name}->{urls}->{$url} = { result => $r->pass};
            $disp->{$r->name}->{result} = $r->pass if $r->pass eq 'fail';
            my $it3 = $r->children;
            while (my $m = $it3->()){
                $disp->{$r->name}->{urls}->{$url}->{mensajes} = $m->message;
            }   
        }   
    }   
    return $disp;
}

=head2 auditoria($id)

Genera el reporte de una auditoría.

El atributo $id debe ser un dato de tipo entero, que corresponda al ID de una auditoría.

=cut

sub auditoria : Local {
	my ( $self, $c, $id ) = @_;
	$c->stash->{template} = 'reportes/auditoria.tt2';
	if ($id) {
		my $auditoria = $c->model('DB::Auditoria')->find({ id => $id },{join => 'idev', join => 'idinstitucion'});
			if ($auditoria && $auditoria->estado eq 'c') {	
				my $disposiciones = disposiciones $auditoria->job;
				foreach (keys %{$disposiciones}){
					my $name = $disposiciones->{$_}->{name};
        			my $dispo = $c->model('DB::Disposicion')->find(
                                { modulo => "$name" },
                                { columns => [ qw / id / ] }
                	);
					my $resolutoria = $c->model("DB::Auditoriadetalle")->find(
						{ idauditoria => $id, iddisposicion => $dispo->id },
                		{ columns => qw / resolutoria / }
	            	);
					$disposiciones->{$_}->{resolutoria} = $resolutoria->resolutoria if $resolutoria;
				}


				# Creo un hash para guardar los datos del producto. 
                my $producto = {};
				$producto->{nombre}      = $auditoria->portal;
                $producto->{solicitante} = $auditoria->idinstitucion->nombre;
                $producto->{direccion}   = $auditoria->idinstitucion->direccion;
                $producto->{fechaini}    = $auditoria->fechaini->dmy();
                $producto->{fechafin}    = $auditoria->fechafin->dmy();
                $producto->{telefono}    = $auditoria->idinstitucion->telefono;
                $producto->{correo}      = $auditoria->idinstitucion->correo;

				# Creo un hash para guardar los datos de la entidad. 
                my $entidad = {};
                $entidad->{nombre}    = $auditoria->idev->nombre;
                $entidad->{telefono}  = $auditoria->idev->telefono;
                $entidad->{direccion} = $auditoria->idev->direccion;
				
                my $resultados = {};
                $resultados->{general} = 'fallo' if !$auditoria->resultado;
                $resultados->{general} = 'paso' if $auditoria->resultado;
                $resultados->{dfail}   = $auditoria->fallidas;
                $resultados->{dpass}   = $auditoria->validas;
				my $indice = ($resultados->{dpass} / ($resultados->{dfail} + $resultados->{dpass})) * 100 ;
                $resultados->{indice}   = $indice;

                $c->stash->{producto}   = $producto;
                $c->stash->{entidad}    = $entidad;
                $c->stash->{resultados} = $resultados;
                $c->stash->{disposiciones} = $disposiciones;
                $c->stash->{id}         = $auditoria->id;
                $c->stash->{titulo}     = "Reporte de la auditoría 000$id";
				use Data::Dumper;
				$c->log->debug(Dumper($disposiciones));
			}
	}
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

