package CNTI::Validator::Test;

has job => ( is => 'ro', isa => 'CNTI::Validator::Monitor::Job', required => 1 );
has url => ( is => 'ro', isa => 'CNTI::Validator::Monitor::URL', required => 1 );
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
        = $url->add_children( { pass => ( $cond ? 'pass' : 'fail' ), name => $self->name } );
    $result->add_chldren( $self->all_events ) if $self->event_count;
}

1;
