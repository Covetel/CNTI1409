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
        $c->stash->{template} = 'instituciones/registrar.tt2';
        if ($form->submitted_and_valid) {
                $c->res->body("Formulario enviado exitosamente");
        }
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

