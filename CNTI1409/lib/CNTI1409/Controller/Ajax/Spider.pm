package CNTI1409::Controller::Ajax::Spider;
use Moose;
use namespace::autoclean;
use CNTI::Spider::UA;
use CNTI::Spider::State;
use CNTI::Spider::UrlList;

BEGIN {extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  'default'   => 'application/json',
);

=head1 NAME

CNTI1409::Controller::Ajax::Spider - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 auto

Redirecciona a Login.

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

    $c->response->body('Matched CNTI1409::Controller::Ajax::Spider in Ajax::Spider.');
}

sub spider_run : Local {
	my ( $self, $c, $base, $depth, $num ) = @_; 
	my $datos;
	my $spider = CNTI::Spider::State->new( base => $base, depth => $depth, num => $num, dir => 0 );
	if ($spider->run){
		$datos->{id} = $spider->id;
    	$self->status_ok($c, entity => $datos);
	}
}

sub monitor : Local : ActionClass('REST') {}

sub monitor_GET {
	my ($self, $c, $id) = @_;
	my $datos = {};
	my @urls;
    # El padre puede monitorear al hijo, creando un objeto con id
    my $monitor = CNTI::Spider::State->new( id => $id);
    $monitor->discard_changes;
	$datos->{estado} = $monitor->state;
	foreach my $url ($monitor->queue){
		push @urls,$url->url;
	}
	$datos->{urls} = \@urls;
	$datos->{urls_total} = $#urls + 1;
    $self->status_ok($c, entity => $datos);
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

