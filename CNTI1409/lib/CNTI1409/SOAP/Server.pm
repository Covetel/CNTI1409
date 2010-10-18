package CNTI1409::SOAP::Server;
use Moose; 
use SOAP::Transport::HTTP; 

has 'address' => (is => 'rw');
has 'port' => (is => 'rw');
has 'clase' => (is => 'rw');
has 'server' => (is => 'ro', isa => 'SOAP::Transport::HTTP::Daemon', lazy => 1, builder => '_server_soap');

sub _server_soap {
	my ($self) = @_;
	return SOAP::Transport::HTTP::Daemon->new(LocalAddr => $self->address, LocalPort => $self->port)->dispatch_to($self->clase); 
	
}

sub start {
	my ($self) = @_;
	$self->server;
	$self->server->handle();
}

1;
