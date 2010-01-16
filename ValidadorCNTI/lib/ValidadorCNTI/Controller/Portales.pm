package ValidadorCNTI::Controller::Portales;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

ValidadorCNTI::Controller::Portales - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ValidadorCNTI::Controller::Portales in Portales.');
}

sub upload : Local {
    my ( $self, $c ) = @_;
	if ( $c->request->parameters->{form_submit} eq 'yes' ) {
            if ( my $upload = $c->request->upload('my_file') ) {
                my $filename = $upload->filename;
                my $target   = "/tmp/$filename";
                unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
                    die( "Failed to copy '$filename' to '$target': $!" );
                }
            }
	}
	$c->stash->{template} = 'Portales/upload.tt2';

}

sub validar : Local {
	my ($self, $c ) = @_; 
	$c->stash->{portales} = [$self->portales];
	$c->stash->{template} = 'Portales/validar.tt2';
}

sub portales {
	# Esta rutina devuelve la lista de portales a chequear. 
	
	# Por ahora los saco de un archivo de texto en /tmp/sitios.txt 
	open PORTALES, "<:encoding(UTF-8)", "/tmp/sitios.txt";
	my @portales = <PORTALES>;
	map { chomp } @portales;
	return @portales;
}

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
