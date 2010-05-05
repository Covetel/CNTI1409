package CNTI1409::Controller::Auditoria;
use Moose;
use namespace::autoclean;

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

    $c->response->body('Matched CNTI1409::Controller::Auditoria in Auditoria.');
}

=head2 crear

=cut

sub crear : Local : FormConfig {
    	my ( $self, $c ) = @_;
		my $form = $c->stash->{form};
        if ($form->submitted_and_valid) {
            # my $upload = $c->request->upload('Examinar');
            # my $pop = $upload->filename;
            # my $archivo = "/tmp/$pop";
            # $upload->copy_to($archivo);
            # open ARCHIVO, "<encoding(UTF-8)", $archivo;
            # my @portales = <ARCHIVO>;
            # $c->res->body("Formulario enviado exitosamente");
            my $auditorias = $c->model('DB::Auditoria')->new_result({});
            $form->model->update($auditorias);
            # $c->flash->{status_msg} = 'Institucion Registrada Correctamente...';
            $c->response->redirect($c->uri_for($self->action_for('crear')));
            $c->detach;
        }
        $c->stash->{template} = 'auditoria/crear.tt2';
}

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

