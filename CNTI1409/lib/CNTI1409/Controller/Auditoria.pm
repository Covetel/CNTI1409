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

sub crear : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
        $c->stash->{mensaje} = $c->req->params->{mensaje};
        my $form = $c->stash->{form};
        if ($form->submitted_and_valid) {
            my $upload = $c->request->upload('Examinar');
            my $pop = $upload->filename;
            my $archivo = "/tmp/$pop";
            $upload->copy_to($archivo);
            open ARCHIVO, "<encoding(UTF-8)", $archivo;
            my @portales = <ARCHIVO>;
            my $idinstitucion = $c->model('DB::Institucion')->find(
                                                                    { "lower(me.nombre)" => lc($c->req->params->{idinstitucion}), habilitado => "true" },
                                                                    { columns => [ qw / id / ] }
                                                                   );
            my $idev = $c->model('DB::Entidadverificadora')->find(
                                                                    { "lower(me.nombre)" => lc($c->req->params->{idev}), habilitado => "true" },
                                                                    { columns => [ qw / id / ] }
                                                                );

            if ($idinstitucion && $idev) {
                $c->model('DB::Auditoria')->create({
                                                       idev            => $idev,
                                                       idinstitucion   => $idinstitucion,
                                                       portal          => $c->req->params->{portal},
                                                       fechacreacion   => DateTime->now,
                                                       url             => \@portales,
                                                   });
                $mensaje = "La auditoría se ha registrado con éxito";
                $c->response->redirect($c->uri_for($self->action_for('crear'),{ mensaje => $mensaje, error => 0}));
            } else {
                $c->stash->{error} = 1;
                my @err_fields = $form->has_errors;
                $c->stash->{mensaje} = "Verifique la institucion o entidad verificadora, los datos no coinciden... ";
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
	#$c->forward('/auditoria/iniciar/',[$id]) if $auditoria->estado eq 'p';
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
		
		# Obtengo las url ya procesadas del Job. 
		my @url_done;
		my @url_run;
		my @url_new;
		my $it = $job->children();
		my $url = 0;
		while ( my $u = $it->() ){
			next if $u->path eq '/';
			push @url_done,$u->path if $u->state eq 'done';
			push @url_new,$u->path if $u->state eq 'new';
			push @url_run,$u->path if $u->state eq 'run';
			$url++;
            # Pruebas para ingresar los datos en BD
            my $uchild = $u->children;
            # $u este hash tengo los siguientes datos
            # path = URL evaluada
            # $uchild
            # haciendo child de este hash obtengo
            # pass = (pass|fail) paso o no la disposicion
            # name = Nombre de la disposicion evaluada
            # $failchild
            # haciendo child de este
            # Solo en caso de pass = fail se crea un hijo con la siguiente info
            # message = Errores obtenidos en la disposicion.
            #while ( my $temp = $uchild->() ) {
                
            #}


		}
		
		my $u_done = $#url_done + 1;
		my $u_pendientes = ($#url_new + 1) + ($#url_run + 1);

		$c->stash->{id} = $id;
		$c->stash->{total_url} = $url;
		$c->stash->{total_done} = $u_done;
		$c->stash->{total_pendientes} = $u_pendientes;
		$c->stash->{url_done} = \@url_done;

        # Variables que tengo disponibles
        # id - id de la auditoria
        # job_id - ID del Job, sirve para consultar los datos necesarios al Job (disposicion, url fallidas, etc.).
        # 
	}
}

=head2 detalle 

Detalle de auditoria 

=cut 

sub detalle : Local {
	my ( $self, $c, $id, $disposicion ) = @_;
	my $h;
	my $ndis; #Nombre disposicion
	my $ddis; #Descripcion disposicion
	my $hash;
	my $auditoria = $c->model('DB::Auditoria')->find({ id => $id });
	my $d = $c->model('DB::Disposicion')->find({ modulo => $disposicion });
	my $disposiciones = $c->model('DB::Disposicion')->search();
	my @disp = $disposiciones->all;
	my $superh;
	foreach my $d (@disp){
		push @{$superh->{disposiciones}},{ nombre => $d->nombre, modulo => $d->modulo };
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
		$hash = $job->as_hash;
		my $it = $job->children();
		while ( my $u = $it->() ){
			next if $u->path eq '/';
			my $it2 = $u->children;
           	while ( my $r = $it2->() ) {
			 	next if $r->name ne $disposicion; 
				push @{$h->{url}},{ disposicion => $r->name, path => $u->path, pass => $r->pass} if $r->pass ne 'pass';
                $c->log->debug($r->pass) if $r->pass ne 'pass';
           	}
		}
	}
	$c->stash->{urls} = \@{$h->{url}};
	$c->stash->{disposiciones} = \@{$superh->{disposiciones}};
	$c->stash->{template} = 'auditoria/detalle.tt2';
}


=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>
Juan Manuel Mesa  <juan@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

