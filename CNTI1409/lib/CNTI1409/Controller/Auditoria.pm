package CNTI1409::Controller::Auditoria;
use Moose;
use namespace::autoclean;
use DateTime;
use utf8;
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Auditoria - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

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


=head2 kill

Detiene una auditoria. 

=cut 

sub kill :Local {
    my ($self, $c, $id) = @_;
    $SIG{CHLD} = "IGNORE";
    if ($id){
        my $auditoria = $c->model('DB::Auditoria')->find($id);
        if ($auditoria){
	        $c->stash->{auditoria} = $auditoria;
	        my $job = $c->model('DB::Job')->find($auditoria->job);
	        my $pid = $job->proc;
	        my $rkill = kill 9, $pid;
	        if ($rkill){
	            $job->delete();
	            $auditoria->estado('p');
                $auditoria->update();
	        } else {
	            $c->stash->{mensaje} = "Esta tratando de detener un proceso que ya no existe";
	            $c->stash->{error} = 1;
	        }
        } else {
            $c->stash->{mensaje} = "La auditoria no existe";
            $c->stash->{error} = 1;
        }
    } else {
        $c->stash->{mensaje} = "Debe indicar el ID de la auditoria";
        $c->stash->{error} = 1;
    }
    $c->stash->{template} = 'auditoria/kill.tt2';
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    if ( $c->user_exists() ) {
        $c->response->body('Matched CNTI1409::Controller::Auditoria in Auditoria.');
    } else {
        $c->response->redirect($c->uri_for('/login'));
    }
}

=head2 crear

=cut

sub crear : Local : Form {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $self->form;

	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );

	my ($entidad_id, $entidad_nombre, $idev);
	if ($c->check_user_roles( qw/Administrador/ )){
		$form->load_config_file('auditoria/crear.yml');
	} elsif ($c->check_user_roles( qw/AuditorJefe/ ) || $c->check_user_roles( qw/Auditor/ )){
		$form->load_config_file('auditoria/crear_auditor.yml');
		# Busco la entidad verificadora a la que pertenece el usuario. 
		my $usuario = $c->user->username;
        my $entidad = $c->model('LDAP')->search(
            base   => $c->config->{base_entidades},
            filter => "(&(objectClass=posixGroup)(memberUid=$usuario))"
        )->shift_entry;
		$entidad_id = $entidad->gidNumber;
		if ($entidad_nombre = $entidad->cn){
			$c->stash->{entidad} = $entidad_nombre;
			utf8::decode($entidad_nombre);
		}

		my $fieldset = $form->get_element({ name => 'seleccionar_entidad' });
		my $block = $fieldset->get_element({ name => 'informacion_entidad_verificadora'});
		$block->content($entidad_nombre);
		
	}
	$form->process;
	$c->stash->{form} = $form;
    if ($form->submitted_and_valid) {
            my $upload = $c->request->upload('Examinar');
			my $ar = $upload->slurp;
            my @portales = split '\n', $ar;
            my $idinstitucion = $c->model('DB::Institucion')->find(
                {
                    "lower(me.nombre)" =>
                      lc( $c->req->params->{idinstitucion} ),
                    habilitado => "true"
                },
                { columns => [qw / id /] }
            );
			# Busco el ID de la entidad verificadora si $entidad_id vale vacio
			if ($entidad_id eq '') {
	            $idev = $c->model('DB::Entidadverificadora')->find(
	                {
	                    "lower(me.nombre)" => lc( $c->req->params->{idev} ),
	                    habilitado         => "true"
	                },
	                { columns => [qw / id /] }
	            );
			} else {
				$idev = $entidad_id;
			}
            if ( $idinstitucion && $idev ) {
                $c->model('DB::Auditoria')->create(
                    {
                        idev          => $idev,
                        idinstitucion => $idinstitucion,
                        portal        => $c->req->params->{portal},
                        fechacreacion => DateTime->now,
                        url           => \@portales,
                    }
                );
                $mensaje = "La auditoría se ha registrado con éxito";
                $c->response->redirect(
                    $c->uri_for(
                        $self->action_for('crear'),
                        { mensaje => $mensaje, error => 0 }
                    )
                );
            }
            else {
                $c->stash->{error} = 1;
                my @err_fields = $form->has_errors;
                $c->stash->{mensaje} = "Verifique la Institución o Entidad Verificadora, los datos no coinciden... ";
            }
        } elsif ($form->has_errors && $form->submitted) {
            $c->stash->{error} = 1;
            my @err_fields = $form->has_errors;
            $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
        }
        $c->stash->{template} = 'auditoria/crear.tt2';
}

=head2 reporte

Carga la template con la tabla HTML preparada. 

=cut 

sub reporte : Local {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'auditoria/listar.tt2';	
} 

=head2 resumen

Presenta una vista resumen de la auditoria. 
En esta vista resumen, se pueden ver los datos: 
- Estado de la auditoria: Pendiente, Abierta, Cerrada
- Fechas 
- Muestra
- Institución.
- Entidad Verificadora Responsable.

=cut 

sub resumen : Local {
    my ( $self, $c, $id ) = @_;
	$c->stash->{template} = 'auditoria/resumen.tt2';	
	my $auditoria = $c->model('DB::Auditoria')->find({ id => $id },{join => 'idev', join => 'idinstitucion'});
	if ($auditoria) {
		# Muestra
		
		my $muestra = join '<br />', @{$auditoria->url};
		$muestra =~ s/&/&amp;/g;
		
		# Variable estado 
		my $estado;
		$estado = 'Abierta' if $auditoria->estado eq 'a';
		$estado = 'Cerrada' if $auditoria->estado eq 'c';
		$estado = 'Pendiente' if $auditoria->estado eq 'p';

		# Si esta abierta, tiene fecha de inicio 
		$c->stash->{fechaini} = $auditoria->fechaini->dmy() if $auditoria->fechaini;
		
		# Si esta cerrada, tiene fecha de cierre. 
		$c->stash->{fechafin} = $auditoria->fechafin->dmy() if $auditoria->fechafin;
		
		$c->stash->{id} = $id;
		$c->stash->{titulo} = "Resumen de la Auditoria 000$id";
		$c->stash->{labelfecha} = 'Fecha de Creación';
		$c->stash->{fecha} = $auditoria->fechacreacion->dmy();
		$c->stash->{institucion} = $auditoria->idinstitucion->nombre;
		$c->stash->{entidad} = $auditoria->idev->nombre;
		$c->stash->{muestra} = $muestra;
		$c->stash->{estado} = $estado;
        $c->stash->{url_count} = $auditoria->url_count;
	} else {
		$c->stash->{titulo} = "Auditoría no encontrada: $id";
	}
} 

=head2 iniciar 

Inicia una auditoría, recibe el ID de la auditoría a iniciar. 

=cut

sub iniciar : Local {
	my ( $self, $c, $id ) = @_;
	my $auditoria = $c->model('DB::Auditoria')->find({ id => $id });
	if ($auditoria->id){
		# Verifico el estado de la auditoría. 
		if ($auditoria->estado eq 'p'){
			# Busco la muestra. 
			my @m = @{$auditoria->url};
			# Saco el dominio 
			my $url = $m[0];
			$url =~ m|(\w+)://([^/:]+)(:\d+)?/(.*)|;
			my $protocolo 	= $1;
			my $dominio 	= $2;
			my $site 		= "$protocolo://$dominio";
			map { $_ =~ s!(\w+)://([^/:]+)(:\d+)?/(.*)!/$4!;} @m;
			my $job = CNTI::Validator::Jobs->new_job(
				site => $site, 
				sample => \@m,	
			);	

			# Guardo el ID del job 
			$auditoria->job($job->id);
			
			# Cambio el estado de la auditoria
			$auditoria->estado('a');
			
			# Fecha de inicio 
			$auditoria->fechaini(DateTime->now());
			# Actualizo el registro auditoria.
			$auditoria->update();
		} 
	}
}

=head2 monitor

Monitor del job, recibe el ID de la auditoría, 
devuelve:
La lista de urls cuyo estado es done. 
El número de urls pendientes.
El número de urls procesadas. 
El estado del job.

=cut

sub monitor : Local {
	my ( $self, $c, $id ) = @_;
	my $auditoria = $c->model('DB::Auditoria')->find({ id => $id });
	my $estado = $auditoria->estado; 
	if ($estado eq 'p'){
		$c->forward('/auditoria/iniciar',[$id]);
	}
	$auditoria = $c->model('DB::Auditoria')->find({ id => $id });
	if ($auditoria->id){
		$c->stash->{template} = 'auditoria/monitor.tt2';
		
		# Obtengo el id del job asociado con esta auditoria
		my $job_id = $auditoria->job;
		
		# Busco el job.
		my $job = CNTI::Validator::Jobs->find_job( $job_id );
        my $j = $c->model('DB::Job')->find($job_id);
		
		$c->stash->{id} = $id;
		$c->stash->{total_url} =  $j->urls_total;
		$c->stash->{total_done} = $j->urls_done;
		$c->stash->{total_pendientes} =  $j->urls_new;
		$c->stash->{url_done} = $j->paths;
        $c->stash->{url_actual} = $j->path_run;
	}
}

=head2 disposiciones($job_id, $estado)

Devuelve un hash que contiene las disposiciones y su estado. 

=cut 

sub disposiciones {
    my ( $job_id, $self, $c ) = @_; 
    my $j = CNTI::Validator::Jobs->find_job($job_id);
    my $it = $j->children;
	# Creo un hash de disposiciones por defecto en 'pass'.
    my $disp = {}; 
	my ($fail, $pass) = 0;
	my @d = $c->model('DB::Disposicion')->all();
	foreach my $d ( @d ) {
		$disp->{$d->modulo} = 'pass';
	}

	# Uso los super iteradores del API.
	while ( my $u = $it->() ) { 
	    my $it2 = $u->children;
	    while (my $r = $it2->()){
			if ($r->pass ne 'pass') {
				$disp->{$r->name} = 'fail';
			}
		}   
	}
	
	# Cuento las disposiciones fail
	map { $fail++ if $disp->{$_} eq 'fail' } keys %{$disp};
	# Cuento las disposiciones pass
	map { $pass++ if $disp->{$_} eq 'pass' } keys %{$disp};

    return ($disp,$pass, $fail);
}

=head2 detalle 

Detalle de auditoria 

=cut 

sub detalle : Local {
	my ( $self, $c, $id, $disposicion ) = @_;
	if ($c->req->method eq 'POST'){
        my $cerrar = $c->req->params->{cerrar};
        if ($cerrar) {
			if ( $c->check_user_roles(qw/Administrador/) || $c->check_user_roles(qw/AuditorJefe/) ){
				# Solo los Administradores o los Auditores Jefes pueden Cerrar una auditoría.
				my $resultado_general = 1;
            	my $id = $c->req->params->{id};
            	my $auditoria = $c->model('DB::Auditoria')->find($id);
				# Busco el job asociado a la auditoria.
				my $job_id = $auditoria->job;
				my ($disp, $pass, $fail) = disposiciones $job_id, $self, $c;
			
				if ($fail > 0){
					$resultado_general = 0;
				}
            	$auditoria->update(
                	{
                    estado    => 'c',
                    fechafin  => DateTime->now,
                    resultado => $resultado_general,
                    fallidas  => $fail,
                    validas   => $pass,
                	}
            	);
            	$c->res->body(1);
			}
        } else {
            my $modulo = $c->req->params->{disposicion};
            my $idAuditoria = $c->req->params->{id};
            my $resolutoria = $c->req->params->{acciones};
            my $auditoria = $c->model('DB::Auditoria')->find({ id => $idAuditoria });
            if ($auditoria->estado eq "c") { 
                $c->stash->{cierra} = "true";
            } else {
                $c->stash->{cierra} = "false";
            }
            if ( $idAuditoria && $modulo ) {
                my $auDetalle = $c->model('DB::Auditoriadetalle');
                my $idDisposicion = $c->model('DB::Disposicion')->find( 
					{ modulo => "$modulo" }, 
					{ columns => [qw / id /] } 
				);

                if ($idDisposicion) {
                    my $data = $idDisposicion->id;
                    $auDetalle->update_or_create({
                            idauditoria => "$idAuditoria",
                            iddisposicion => "$data",
                            resolutoria => "$resolutoria"
                    });
                    $c->res->body(1);
                }
            } else {
                $c->res->body(0);
            }
        }
	}
	if ($disposicion && $id) {
		my $h;
		my $site;
		my $auditoria = $c->model('DB::Auditoria')->find({ id => $id });
	    $c->stash->{auditoria} = $auditoria;
	    my $job = CNTI::Validator::Jobs->find_job( $auditoria->job );
	    $c->stash->{portal} = $job->site; 
		my $d = $c->model('DB::Disposicion')->find({ modulo => $disposicion });
	    $c->stash->{d} = $d;
	    $c->stash->{disposicion} = $disposicion;

        # Hash con las urls y los mensajes de error por cada url de esta
        # disposicion 
        #my $disposiciones = $c->model('DB::ResultadosDisposicion')->disposiciones($auditoria->job);
        #$c->stash->{disposiciones} = $disposiciones;
        $DB::single=1;
        $c->log->debug($auditoria->results->id);
        my $scalar = $auditoria->results->fromjson;
        $c->stash->{disposiciones} = $scalar; 


        my $resolutoria = $c->model("DB::Auditoriadetalle")->find(
                { idauditoria => $id, iddisposicion => $d->id },
                { columns => qw / resolutoria / }
            );

        if ($resolutoria) {
            $c->stash->{acciones} = $resolutoria->resolutoria;
        }
        if ($auditoria->estado eq "c") { 
            $c->stash->{cierra} = 1;
        } else {
            $c->stash->{cierra} = 0;
        }
	
		$c->stash->{template} = 'auditoria/detalle.tt2';


=pod        
		my $disposiciones = $c->model('DB::Disposicion')->search();
		my @disp = $disposiciones->all;
		my $superh;
		foreach my $d (@disp){
			my $activa = 1 if $d->modulo eq $disposicion; 
			push @{$superh->{disposiciones}},{ nombre => $d->nombre, modulo => $d->modulo, activa => $activa, pass => 'pass' };
		}
		
		if ($d->id){
			$ndis = $d->nombre;
			$ddis = $d->descripcion;
		    $c->stash->{nombre} = $ndis;
		    $c->stash->{descripcion} = $ddis;
		}
		if ($auditoria->id){
	        $c->stash->{idAuditoria} = $auditoria->id;
			my $job_id = $auditoria->job;
			my $job = CNTI::Validator::Jobs->find_job( $job_id );
			$site = $job->site;
            # $hash = $job->as_hash;
			my $it = $job->children();
			while ( my $u = $it->() ){
				#next if $u->path eq '/';
				my $it2 = $u->children;
                my $sitios;
	           	while ( my $r = $it2->() ) {
				 	next if $r->name ne $disposicion; 
                    $sitios = $site . $u->path;
					$sitios =~ s/&/&amp;/g;
					push @{$h->{url}},{ disposicion => $r->name, path => $sitios, pass => $r->pass} if $r->pass ne 'pass';
                    $pass = 'fail' if ($r->pass ne 'pass');
                    if ($r->pass ne 'pass') {
                        my $it3 = $r->children;
                        while ( my $r2 = $it3->()) {
							my $mensaje = $r2->message;
							$mensaje =~ s/&/&amp;/g;
                            push @{$errores->{er}},{ sitio => $sitios, error => $mensaje };
                        }
                    }
	           	}
			}
		}
        
=cut

        # Verificamos si existe un comentario de acciones correctivas
        # para esta disposicion
	}
}


=head2 save_results

Recibe el id de la auditoría, construye un hash con los resultados,  los
serializa en JSON y los guarda en base de datos. 

=cut 


sub save_results : Local {
	my ( $self, $c, $id ) = @_;
    if ($id) {
        # Busco la auditoria    
        my $auditoria = $c->model('DB::Auditoria')->find($id);
        if ($auditoria){
            # Construyo el hash
            my $disp = $c->model('DB::ResultadosDisposicion')->disposiciones($auditoria->job);

            # Serializo en JSON codificado UTF8
            my $json_disp = JSON::XS->new->utf8(1)->encode($disp);
            
            # Guardo los datos.
			my $json_db = $c->model('DB::AuditoriaResult')->create({
			        id_auditoria => $auditoria->id, 
			        json => $json_disp,
			});
        } else {
            $c->res->body("3"); # Auditoria no encontrada 
        } 
    } else {
        $c->res->body("2");  # ID no suministrado
    }
    $c->res->body("1"); # Resultados guardados
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>
Juan Manuel Mesa  <juan@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

