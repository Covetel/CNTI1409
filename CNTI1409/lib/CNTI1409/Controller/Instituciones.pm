package CNTI1409::Controller::Instituciones;
use Moose;
use namespace::autoclean;
use utf8;
use Try::Tiny;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Instituciones - Catalyst Controller

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
	$c->assert_user_roles(qw/Administrador/);
    return 1;
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched CNTI1409::Controller::Instituciones in Instituciones.');
}

sub registrar : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
	
	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );

    if ($form->submitted_and_valid) { 
        my $instituciones = $c->model('DB::Institucion')->new_result({});
        $form->model->update($instituciones);
        $mensaje = "La Institución " . $form->param_value('nombre') . " se ha registrado con éxito";
        $c->response->redirect($c->uri_for($self->action_for('registrar'),{ mensaje => $mensaje, error => 0}));
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
		my $label = $form->get_field($err_fields[0])->label; 
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo <span class='strong'> $label </span> ";
    }
    $c->stash->{template} = 'instituciones/registrar.tt2';
}

sub editar : Local : FormConfig('instituciones/editar.yml') {
    my ( $self, $c, $id ) = @_;
	$c->stash->{titulo} = "Actualizar Institución";
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
	
	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );
    if ($form->submitted_and_valid) { 
		# Obtengo el id escondido en el campo id.
		$id = $form->param_value('id');
    	my $instituciones = $c->model('DB::Institucion')->find($form->param_value('id'));
        $form->model->update($instituciones);
        my $mensaje = "La Institución " . $form->param_value('nombre') . " se ha actualizado con éxito";
		$c->stash->{mensaje} = $mensaje;
	} elsif ($form->has_errors && $form->submitted) {
		$id = $form->param_value('id');
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
		my $label = $form->get_field($err_fields[0])->label; 
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo <span class='strong'> $label </span> ";
    }
    my $instituciones = $c->model('DB::Institucion')->find($id);
	$form->model->default_values($instituciones);
    $c->stash->{template} = 'instituciones/registrar.tt2';
}

sub listar : Local {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'instituciones/listar.tt2';	
} 


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

