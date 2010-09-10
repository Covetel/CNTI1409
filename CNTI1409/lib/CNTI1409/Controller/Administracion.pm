package CNTI1409::Controller::Administracion;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Administracion - Catalyst Controller

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

    $c->response->body('Matched CNTI1409::Controller::Administracion in Administracion.');
}


sub fonts : Local : FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
	$c->stash->{titulo}     = "Gestión de parámetros de disposiciones";
	$c->stash->{template} = 'administracion/parametros.tt2';
	if ($form->submitted_and_valid) {
        use WWW::Mechanize;    
        my $row = $c->model("DB::disposicion")->find( 
			{
				modulo => "Fonts",
			},
			{
				columns => [ qw / id / ] 
			}
        );
        my $mech = WWW::Mechanize->new;
        $mech->get("http://fonts.debian.net");
        my @list;
        my @fonts = $mech->find_all_images( alt_regex => qr/\.ttf$/ );
        for my $font (@fonts) {
            my $fuente = $font->alt;
            $fuente =~ s/(.*)\.ttf$/$1/;
            my $result = $c->model('DB::param')->create({
                disposicion   => "Fonts",
                parametro       => $fuente,
            });
        }
    }
}

sub metas : Local : FormConfig {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'administracion/metas.tt2';	
} 


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

