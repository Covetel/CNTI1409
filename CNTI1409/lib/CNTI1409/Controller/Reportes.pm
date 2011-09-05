package CNTI1409::Controller::Reportes;
use Moose;
use namespace::autoclean;
use utf8;
use LaTeX::Encode; # Módulo necesario para codificar las urls que van para el PDF.
use Data::Dumper;
use Chart::Bars; 

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Reportes - Catalyst Controller

=head1 DESCRIPTION

Esta controladora es responsable de generar todos los reportes del sistema.

=head1 METHODS

=cut

=head2 auto

Redirecciona a Login.

=cut

sub auto :Private {
    my ( $self, $c ) = @_;
    if ($c->controller eq $c->controller('Root')->action_for('login')) {
        return 1;
    }
    if (!$c->user_exists) {
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }
    return 1;
}

=head2 index


=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->detach('wizard');
	
}

=head2 wizard

Este método, genera un wizard html que permite la creación de reportes custom. 

=cut

sub wizard : Local : Form {
	my ( $self, $c ) = @_;
	$c->assert_user_roles(qw/AuditorJefe/);

	my ($entidad_id, $entidad_nombre);
	my $form = $self->form;
	
	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );

	$c->stash->{titulo}     = "Generador de Reportes";
	$c->stash->{template} 	= 'reportes/wizard.tt2';
	if ($c->check_user_roles( qw/Administrador/ )){
		$form->load_config_file('reportes/wizard.yml');
	} elsif ($c->check_user_roles( qw/AuditorJefe/ ) || $c->check_user_roles( qw/Auditor/ )){
		$form->load_config_file('reportes/wizard_auditor.yml');
		# Busco la entidad verificadora a la que pertenece el usuario. 
		my $usuario = $c->user->username;
        my $entidad = $c->model('LDAP')->search(
            base   => $c->config->{base_entidades},
            filter => "(&(objectClass=posixGroup)(memberUid=$usuario))"
        )->shift_entry;
		$entidad_id = $entidad->gidNumber;
		$entidad_nombre = $entidad->cn;
	}
	$form->process;
	$c->stash->{form} = $form;
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
		my @datos;
		if ($c->check_user_roles( qw/Administrador/ )){
			@datos = $c->model('DB::Auditoria')->search({ $filtro => $idpatron, fechaini => {-between => [$desde, $hasta]} });
		} elsif ($c->check_user_roles( qw/AuditorJefe/ ) || $c->check_user_roles( qw/Auditor/ )){
			@datos = $c->model('DB::Auditoria')->search({ idev => $entidad_id, $filtro => $idpatron, fechaini => {-between => [$desde, $hasta]} });

		}
		my @auditorias;
		foreach my $dato (@datos){
			my $auditoria = {};
			$auditoria->{id} = $dato->id;
			$auditoria->{institucion} = $dato->idinstitucion->nombre;
			$auditoria->{portal} = $dato->portal;
			$auditoria->{estado} = 'Abierta' if $dato->estado eq 'a';
			$auditoria->{estado} = 'Pendiente' if $dato->estado eq 'p';
			$auditoria->{estado} = 'Cerrada' if $dato->estado eq 'c';
			$auditoria->{fecha} = $dato->fechacreacion->dmy();
			$auditoria->{entidad} = $dato->idev->nombre;
			$auditoria->{fail} = $dato->fallidas;
			$auditoria->{pass} = $dato->validas;
			if ($dato->estado eq 'c'){
				my $validas = $dato->validas;
				my $fallidas = $dato->fallidas;
				my $indice = ($validas / ($fallidas + $validas)) * 100 ;
				$indice = sprintf("%.2f",$indice);
				$auditoria->{indice} = $indice;
			}
			
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
    my ( $auditoria_results ) = @_;
    my $disp = {}; 
    foreach my $disp_name (keys %{$auditoria_results}){
        $disp->{$disp_name}->{name} = $disp_name;
        $disp->{$disp_name}->{result} = $auditoria_results->{$disp_name}->{'state'};
        foreach my $u (keys %{ $auditoria_results->{$disp_name}->{'urls'} }){
           $disp->{$disp_name}->{urls}->{$u} = { result => 'fail' };
           $disp->{$disp_name}->{urls}->{$u}->{mensajes} = $auditoria_results->{$disp_name}->{'urls'}->{$u}->{mensajes}; 
        }
    
    }
    return $disp;
    
=pod 
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
=cut 
}

sub grafica {
	my ($cumple,$no_cumple,$institucion) = @_;
	
	my $title = 'Gráfico de índice de cumplimento';
	utf8::decode($title);
	utf8::decode($institucion);
	my $obj = Chart::Bars->new(600,300); 

	$obj->set(title => $title);
	$obj->set(y_label => 'Disposiciones');
	$obj->set(min_val => 1);
	$obj->set(max_val => 16);
	$obj->set(integer_ticks_only => 'true');
	$obj->set(legend_labels => ['No Cumple','Cumple']);
	$obj->add_dataset($institucion);
	$obj->add_dataset($no_cumple);
	$obj->add_dataset($cumple);
	$obj->png('root/static/images/grafica.png');
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
                
				my $disposiciones = disposiciones $auditoria->results->fromjson;
				foreach (keys %{$disposiciones}){
					my $name = $disposiciones->{$_}->{name};
        			my $dispo = $c->model('DB::Disposicion')->find(
                                { modulo => "$name" },
                                { columns => [ qw / id / ] }
                	);
					next if !$dispo;
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
				
				&grafica($resultados->{dpass}, $resultados->{dfail}, $producto->{solicitante});
			} else {
				$c->stash->{error} = 1;
				$c->stash->{mensaje} = 'La auditoría no existe o no esta cerrada. Solo se generan reportes para las auditorías cuyo estado es Cerrado';
			}
	}
}

sub urls_report : Local {
	my ( $self, $c, $id, $disp ) = @_;
	my $auditoria = $c->model('DB::Auditoria')->find($id);
    my $disposiciones = disposiciones $auditoria->results->fromjson;
    my $d = $disposiciones->{$disp};
    $c->stash->{disp} = $d;
	$c->stash->{template} = 'reportes/urls.tt2';
    $c->detach( 'CNTI1409::View::Ajax' );
    
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
	$auditoria->{estado}= $aud->estado;
	$auditoria->{entidad}->{nombre}= $aud->idev->nombre;
	#$auditoria->{entidad}->{telefono}= $aud->idev->telefono;
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

	# Busco los resultados por disposicion. 
	my $resultados = disposiciones $aud->job;
	
	# Itero por todas las disposiciones.
	foreach my $disposicion (keys %{ $disp }) {
		# Si no hay resultados para la disposición en el Job, entonces next.
		next if $resultados->{$disposicion} eq '' ;
		$auditoria->{disposiciones}->{$disposicion} = $disp->{$disposicion};
		my @urls;
		foreach my $url (keys %{$resultados->{$disposicion}->{urls}}){
			my $path = latex_encode($url); 
			my $u = { latex_url => $path, path => $url, datos => $resultados->{$disposicion}->{urls}->{$url}};
			my $mensaje = $u->{datos}->{mensajes};
			if ($mensaje){
				$mensaje = latex_encode($mensaje);
				$u->{datos}->{mensajes} = $mensaje;
			}
			push @urls, $u;	
		}
		$auditoria->{disposiciones}->{$disposicion}->{rutas} = \@urls;
		if ($resultados->{$disposicion}->{result}){
			$auditoria->{disposiciones}->{$disposicion}->{resultado} = 'Incumple';
			# Busco la resolutoria que agrego el auditor a la disposicion. 
			my $resolutoria = $c->model("DB::Auditoriadetalle")->find(
				{ idauditoria => $id, iddisposicion => $disp->{$disposicion}->{id} },
				{ columns => qw / resolutoria / }
			);
			if ($resolutoria && $resolutoria->resolutoria) {
				$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = $resolutoria->resolutoria;
			} else {
				$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = 'El auditor no indico una acción resolutoria';
			}
		} else {
			$auditoria->{disposiciones}->{$disposicion}->{resultado} = 'Cumple';
			$auditoria->{disposiciones}->{$disposicion}->{resolutoria} = 'No Aplica';
		}
	}
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
	my $aud = $c->model('DB::Auditoria')->find($id);
	if ($aud->estado eq 'c'){
		my $auditoria = auditoria_struct($self,$c,$id);
		my $file = "auditoria-".$auditoria->{id}.".pdf";
		$c->stash->{auditoria} = $auditoria;
		if ($c->forward( 'CNTI1409::View::PDF' ) ) {
     	# Only set the content type if we sucessfully processed the template
     		$c->response->content_type('application/pdf');
     		$c->response->header('Content-Disposition', "attachment; filename=$file");
  		}
	} else {
		$c->stash->{template} = 'reportes/auditoria.tt2';
		$c->stash->{error} = 1;
		$c->stash->{mensaje} = 'La auditoría no existe o no esta cerrada. Solo se generan reportes para las auditorías cuyo estado es Cerrado';
	}
}

=head2 entidades 

Genera un reporte HTML de entidades listo para imprimir.

=cut 

sub entidades : Local {
	my ( $self, $c ) = @_;
	$c->assert_user_roles(qw/Administrador/);
	# Busco la lista de entidades. 
	my @entidades = $c->model('DB::Entidadverificadora')->search({})->all();
	$c->stash->{entidades} = \@entidades;
	$c->stash->{template} = 'reportes/entidades.tt2';
}

=head2 instituciones

Genera un reporte HTML de instituciones lista para imprimir.

=cut 

sub instituciones : Local {
	my ( $self, $c ) = @_;
	$c->assert_user_roles(qw/Administrador/);
	# Busco la lista de instituciones
	my @instituciones = $c->model('DB::Institucion')->search({})->all();
	$c->stash->{instituciones} = \@instituciones;
	$c->stash->{template} = 'reportes/instituciones.tt2';
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

