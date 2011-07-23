package CNTI1409::Controller::Ajax::Monitor;
use Moose;
use namespace::autoclean;
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;

BEGIN {extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  'default'   => 'application/json',
);

=head1 NAME

CNTI1409::Controller::Ajax::Monitor - Catalyst Controller

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


=head2 index

=cut

sub auditoria : Local : ActionClass('REST') {}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Ajax::Monitor in Ajax::Monitor.');
}

=head2 auditoria_GET 

Devuelve un objecto JSON con la información sobre el job y los hijos del job para una Auditoría. 

=cut

sub auditoria_GET {
    my ( $self, $c, $id ) = @_;
	if ($id) {
		my $auditoria = $c->model('DB::Auditoria')->find({ id => $id });
		if ($auditoria->id){
			$c->stash->{template} = 'auditoria/monitor.tt2';
			
			# Obtengo el id del job asociado con esta auditoria
			my $job_id = $auditoria->job;
			
            # Busco el job en la base de datos. 
            my $j = $c->model('DB::Job')->find($auditoria->job);
            
			# Obtengo las url ya procesadas del Job. 
			my $datos;
			$datos->{id} = $id;
			$datos->{total_url} = $j->urls_total;
			$datos->{total_done} = $j->urls_done;
			$datos->{total_pendientes} = $j->urls_new;
			$datos->{url_done} = $j->paths;
			$datos->{url_actual} = $j->path_run;
    		$self->status_ok($c, entity => $datos);
			
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

