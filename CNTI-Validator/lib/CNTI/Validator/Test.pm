package CNTI::Validator::Test;
use Moose;

has url => ( is => 'ro', isa => 'CNTI::Validator::Monitor::URL', required => 1 );
has task => ( is => 'ro', isa => 'CNTI::Validator::Tests', required => 1, handles => { job => 'job', cache => 'cache' } );
has events => (
    is      => 'ro',
    isa     => 'ArrayRef[HashRef]',
    default => sub { [] },
    traits  => ['Array'],
    handles => { event_add => "push", event_list => 'elements', event_count => 'count' }
);

sub ok {
    my $self = shift;
    my $cond = shift;
    my $result
        = $self->url->add_child( { pass => ( $cond ? 'pass' : 'fail' ), name => $self->name } );
    $result->add_children( $self->event_list ) if $self->event_count;
}

sub event_log {
    my ($self, $class, $mesg, $data) = @_;
    my $ev = { class => $class, message => $mesg };
    $ev->{'data'} = shift if $data;
    $self->event_add( $ev );
}

sub name {
    my $self = shift;
    my $name = ref($self);
    $name =~ s/.*://;
    $name;
}

package CNTI::Validator::Test::Domain;
use Moose;
use URI;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $uri  = URI->new( $self->job->site );
    $self->event_log('info', 'Un comentario banal');
    $self->ok( $uri->authority =~ /\.gob\.ve$/, "Dominio incorrecto" );
}

package CNTI::Validator::Test::Title;
use Moose;
use CNTI::Validator::LibXML;
use HTML::TreeBuilder;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $cache->response->content );
    my $node = $tree->find('html');
    unless ( $node ) {
        $self->event_log('error', 'No es HTML');
        return $self->ok(0);
    }
    $node = $node->find('head');
    unless ( $node ) {
        $self->event_log('error', 'No tiene HEAD');
        return $self->ok(0);
    }
    $node = $node->find('title');
    unless ( $node ) {
        $self->event_log('error', 'No tiene TITLE');
        return $self->ok(0);
    }
    my @cont = $node->content_list;
    if ( @cont == 1 and ! ref $cont[0] ) {
        return $self->ok(1);
    }
    else {
        $self->event_log('error', 'TITLE mal formado: ' . $node->as_HTML);
        return $self->ok(0);
    }

# Nunca se llega aqui XXX    
    my $xp = CNTI::Validator::LibXML->new( xml => $tree->as_XML, options => {recover=>1} );
    my $title = $xp->xpc->findvalue('/html/head/title', $xp->doc);
    if ( $title ) {
        $self->ok( 1, "TITLE" );
    }
    else {
        $self->ok( 1, "No hay TITLE" );
    }
    return;
}

1;
