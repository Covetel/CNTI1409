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
    if ($form->submitted_and_valid) { 
        my $instituciones = $c->model('DB::Institucion')->new_result({});
        $form->model->update($instituciones);
        $mensaje = "La institución " . $form->param_value('nombre') . " se ha registrado con exito";
        $c->response->redirect($c->uri_for($self->action_for('registrar'),{ mensaje => $mensaje, error => 0}));
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
    }
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
