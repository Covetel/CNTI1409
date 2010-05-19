package CNTI1409::Controller::Entidades;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Entidades - Catalyst Controller

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

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Entidades in Entidades.');
}

=head2 registrar

Este método crea el formulario para registrar entidades verificadoras

=cut

sub registrar : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) { 
        my $entidad = $c->model('DB::Entidadverificadora')->new_result({});
        $form->model->update($entidad);
        $mensaje = "La entidad " . $form->param_value('nombre') . " se ha registrado con exito";
        $c->response->redirect($c->uri_for($self->action_for('registrar'),{ mensaje => $mensaje, error => 0}));
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
    }
    $c->stash->{template} = 'entidades/registrar.tt2';
}

sub listar : Local {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'entidades/listar.tt2';	
} 

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

