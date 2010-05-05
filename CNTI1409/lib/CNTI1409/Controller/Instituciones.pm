package CNTI1409::Controller::Instituciones;
use Moose;
use namespace::autoclean;

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
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) { 
        my $instituciones = $c->model('DB::Institucion')->new_result({});
        $form->model->update($instituciones);
        # $c->flash->{status_msg} = 'Institucion Registrada Correctamente...';
        $c->response->redirect($c->uri_for($self->action_for('registrar')));
        $c->detach;
    } 
    $c->stash->{template} = 'instituciones/registrar.tt2';
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

