package CNTI::Validator::Tests;
use Moose;

use WWW::Mechanize::Cached;
use CNTI::Validator::Test;

has job   => ( is => 'ro', isa => 'CNTI::Validator::Monitor::Job', required => 1 );
has cache => ( is => 'ro', isa => 'WWW::Mechanize::Cached',        required => 1 );

my @tests = qw(Domain Title UTF8 Img Alt JS JS_inc HTML4);

around BUILDARGS => sub {
    my ( $orig, $class, $job ) = @_;
    my $cache = WWW::Mechanize::Cached->new;
    $cache->env_proxy();
    $cache->agent_alias("Linux Mozilla");
    { job => $job, cache => $cache };
};

sub run {
    my $self = shift;
    my $ch   = $self->job->children;
    return unless $ch;

    while ( my $url = $ch->() ) {
        $url->set_state('run');
        $self->run_test( $_, $url ) for @tests;
        $url->set_state('done');
    }
}

sub run_test {
    my $self = shift;
    my ( $name, $url ) = @_;
    my $class = "CNTI::Validator::Test::$name";
    eval { $class->new( task => $self, url => $url )->run }
}

1;
