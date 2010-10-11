package CNTI1409::Controller::Spider;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Spider - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Spider in Spider.');
}

sub iniciar : Local : FormConfig {
	my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
	
	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );

	use Data::Dumper;
	$c->stash->{id} = 0;
    if ($form->submitted_and_valid) { 
			$c->stash->{base} = $c->req->params->{base};
			$c->stash->{prof} = $c->req->params->{prof};
			$c->stash->{numero} = $c->req->params->{numero};
		if ($c->req->params->{prof} == 0){
			$c->req->params->{prof} = 1000000;
		}
        my $spider = CNTI::Spider::State->new(
            base  => $c->req->params->{base},
            depth => $c->req->params->{prof},
            num   => $c->req->params->{numero},
            dir   => 0
        );
		if ($spider->run){
			$c->stash->{id} = $spider->id;
		}
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
		my $label = $form->get_field($err_fields[0])->label; 
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo <span class='strong'> $label </span>";
    }
	$c->log->debug($form->has_errors);
	$c->log->debug($form->submitted);
	$c->stash->{template} = 'spider/spider_form.tt2';
}

sub muestra : Local {
	my ( $self, $c, $id ) = @_;
	my @urls;
    my $spider = CNTI::Spider::State->new( id => $id);
	foreach my $url ($spider->queue){
		push @urls,$url->url;
	}
	use Data::Dumper;
	#$c->response->body(Dumper(\@urls));
	my $muestra = join "\n", @urls;
	$c->response->body($muestra);
    $c->response->content_type('text/plain');
    $c->response->header('Content-Disposition', "attachment; filename=muestra_".$id.".txt");
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

