package CNTI::Validator::Tests;

my @tests = qw();

sub run {
    my $self = shift;
    my ($job, $url) = @_;
    $self->run_test( $_, $job, $url ) for @tests;
}

sub run_test {
    my $self = shift;
    my ($name, $job, $url) = @_;
    my $class = "CNTI::Validator::Test::$name";
    $class->new( $job, $url )->new;
}

1;
