package CNTI1409::Controller::Reportes;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Reportes - Catalyst Controller

=head1 DESCRIPTION

Esta controladora es responsable de generar todos los reportes del sistema.

=head1 METHODS

=cut


=head2 index


=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->detach('wizard');
	
}

=head2 wizard

Este método, genera un wizard html que permite la creación de reportes custom. 

=cut

sub wizard : Local : FormConfig {
	my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
	$c->stash->{titulo}     = "Generador de Reportes";
	$c->stash->{template} 	= 'reportes/wizard.tt2';
	if ($form->submitted_and_valid) {
		my $desde = $c->req->params->{'desde'};	
		my $hasta = $c->req->params->{'hasta'};	
		my $filtro = $c->req->params->{'filtro'};
		my $patron = $c->req->params->{'patron'};
		my $tabla;

		$tabla 	= 'Institucion' if 	$filtro eq 'idinstitucion';
		$tabla 	= 'Entidadverificadora' if $filtro eq 'idev';
		
        my $row = $c->model("DB::$tabla")->find( 
			{
				"lower(me.nombre)" => lc($patron), 
				habilitado => "true" 
			},
			{
				columns => [ qw / id / ] 
			}
        );
		my $idpatron = $row->id;
		$c->log->debug($idpatron);
		my @datos = $c->model('DB::Auditoria')->search({ $filtro => $idpatron, fechaini => {-between => [$desde, $hasta]} });
		my @auditorias;
		foreach my $dato (@datos){
			my $auditoria = {};
			$auditoria->{id} = $dato->id;
			$auditoria->{institucion} = $dato->idinstitucion->nombre;
			$auditoria->{portal} = $dato->portal;
			$auditoria->{estado} = $dato->estado;
			$auditoria->{fecha} = $dato->fechacreacion->dmy();
			$auditoria->{entidad} = $dato->idev->nombre;
			$auditoria->{fail} = $dato->fallidas;
			$auditoria->{pass} = $dato->validas;
			my $indice = ($dato->validas / ($dato->fallidas + $dato->validas)) * 100 ;
			$indice = sprintf("%.2f",$indice);
			$auditoria->{indice} = $indice;
			push @auditorias, $auditoria;
		}
		$c->stash->{auditorias} = \@auditorias;
		$c->stash->{template} = 'reportes/wizard-reporte.tt2';
	} elsif ( $form->has_errors && $form->submitted ){
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
	}
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
                $entidad->{nacreditacion}    = $auditoria->idev->registro;
                $entidad->{nombre}    = $auditoria->idev->nombre;
                $entidad->{telefono}  = $auditoria->idev->telefono;
                $entidad->{direccion} = $auditoria->idev->direccion;
				
                my $resultados = {};
                $resultados->{general} = 'fallo' if !$auditoria->resultado;
                $resultados->{general} = 'paso' if $auditoria->resultado;
                $resultados->{dfail}   = $auditoria->fallidas;
                $resultados->{dpass}   = $auditoria->validas;
				my $indice = ($resultados->{dpass} / ($resultados->{dfail} + $resultados->{dpass})) * 100 ;
				# Redondeo el número.
				$indice = sprintf("%.2f",$indice);
                $resultados->{indice}   = $indice;

                $c->stash->{producto}   = $producto;
                $c->stash->{entidad}    = $entidad;
                $c->stash->{resultados} = $resultados;
                $c->stash->{disposiciones} = $disposiciones;
                $c->stash->{id}         = $auditoria->id;
                $c->stash->{titulo}     = "Reporte de la auditoría 000$id";
			}
	}
}

=head2 auditoria_struct ($id) 

Este método devuelve un hash que contiene los datos
de una auditoria. 

=cut

sub auditoria_struct {
	my ( $self, $c, $id ) = @_;
	my $auditoria = {};
	my $aud = $c->model('DB::Auditoria')->find($id);
	$auditoria->{entidad} = {};
	$auditoria->{portal} = $aud->portal;
	$auditoria->{fechacreacion}= $aud->fechacreacion->dmy();
	$auditoria->{fechaini}= $aud->fechaini->dmy();
	$auditoria->{fechafin}= $aud->fechafin->dmy();
	$auditoria->{institucion}->{nombre}= $aud->idinstitucion->nombre;
	$auditoria->{institucion}->{telefono}= $aud->idinstitucion->telefono;
	$auditoria->{institucion}->{direccion} = $aud->idinstitucion->direccion;
	$auditoria->{institucion}->{correo}= $aud->idinstitucion->correo;
	$auditoria->{id}= $id;
	$auditoria->{entidad}->{registro}= $aud->idev->registro;
	$auditoria->{entidad}->{nombre}= $aud->idev->nombre;
	$auditoria->{entidad}->{telefono}= $aud->idev->telefono;
	$auditoria->{entidad}->{direccion} = $aud->idev->direccion;
	$auditoria->{entidad}->{correo}= $aud->idev->correo;
	$auditoria->{cumple}= $aud->resultado;
	$auditoria->{validas}= $aud->validas;
	$auditoria->{fallidas} = $aud->fallidas;
	my $indice = ($auditoria->{validas} / ($auditoria->{fallidas} + $auditoria->{validas})) * 100 ;
	# Redondeo el número.
	$indice = sprintf("%.2f",$indice);
	$auditoria->{indice}   = $indice;

	my $resolutoria = $c->model('DB::Auditoriadetalle')->search({ idauditoria => $id})->count();
	if ($resolutoria > 0) {
		$auditoria->{acciones_correctivas}= 1;
	} else {
		$auditoria->{acciones_correctivas}= 0;
	}
	
	# Busco la estructura de disposiciones.
	my $disp = &disposiciones_struct;
	$auditoria->{disposiciones} = $disp;

	# Busco los resultados por disposicion. 
	my $resultados = disposiciones $aud->job;
	
	# Itero por todas las disposiciones.
	foreach my $disposicion (keys %{ $disp }) {
		if ($resultados->{$disposicion}->{result}){
			$auditoria->{disposiciones}->{$disposicion}->{resultado} = 'No Cumple';
			# Busco la resolutoria que agrego el auditor a la disposicion. 
			my $resolutoria = $c->model("DB::Auditoriadetalle")->find(
				{ idauditoria => $id, iddisposicion => $disp->{$disposicion}->{id} },
				{ columns => qw / resolutoria / }
			);
			if ($resolutoria->resolutoria) {
				$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = $resolutoria->resolutoria;
			} else {
				$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = 'El auditor no indico una acción resolutoria';
			}
		} else {
			$auditoria->{disposiciones}->{$disposicion}->{resultado} = 'Cumple';
			$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = 'No Aplica';
		}
	}
	use Data::Dumper;
	$c->log->debug(Dumper($auditoria));
	return $auditoria;
}

sub disposiciones_struct : Local {
	my ( $self, $c ) = @_;
	# Me traigo todas las disposiciones que existen en la base de datos.
	my @disposiciones = $c->model('DB::Disposicion')->search({habilitado => 'true'})->all();
	my $disp = {};
	foreach my $disposicion (@disposiciones){
		$disp->{$disposicion->modulo}->{nombre} = $disposicion->nombre;
		$disp->{$disposicion->modulo}->{descripcion} = $disposicion->descripcion;
		$disp->{$disposicion->modulo}->{descripcion_prueba} = $disposicion->descripcion_prueba;
		$disp->{$disposicion->modulo}->{id} = $disposicion->id;
	}
	return $disp;
}

=head2 pdf($id)

Recibe el ID de una auditoría y genera un reporte en PDF de la misma.

=cut

sub pdf : Local {
	my ( $self, $c, $id ) = @_;
	my $auditoria = auditoria_struct($self,$c,$id);
	my $file = "auditoria-".$auditoria->{id}.".pdf";
	$c->stash->{auditoria} = $auditoria;
	if ($c->forward( 'CNTI1409::View::PDF' ) ) {
     # Only set the content type if we sucessfully processed the template
     $c->response->content_type('application/pdf');
     $c->response->header('Content-Disposition', "attachment; filename=$file");
  	}

}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

