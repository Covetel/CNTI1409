use utf8;
use feature ":5.10";
use strict;

package AracniState;
use Moose;
use AracniSchema;
use Digest::MD5 'md5_hex';
use URI::URL;

=pod

# num: número de hijos para cada nodo
# dir: dirección para adquirir los hijos
# depth: niveles de profundidad 0 => solo el URL actual
# queue: cola con todos los urls recolectados
has queue => (
    is      => "ro",
    isa     => "HashRef[Str]",
    default => sub { {} },
    traits  => ["Hash"],
    handles =>
        { queue_get => "get", queue_set => "set", queue_exists => "exists" }
);

=cut

has job => ( is => "ro", isa => "CNTI::SpiderDB::Result::SpiderJob",
    handles => { ( map { $_ => $_ } qw(base num dir depth state) ) } );

sub BUILDARGS {
    my $class = shift;
    my %args = @_;
    my %rec;
    $rec{'num'}   = $args{'num'}   || 0;
    $rec{'dir'}   = $args{'dir'}   || 0;
    $rec{'depth'} = $args{'depth'} || 0;
    $rec{'state'} = $args{'state'} || 0;
    $rec{'base'}  = $args{'base'}  || die "base is required";
    return { job   => AracniSchema->resultset("SpiderJob")->create( \%rec ) }
}


my @all_states = qw( new running done );

sub is_new     { shift->state == 0 }
sub is_running { shift->state == 1 }
sub is_done    { shift->state == 2 }
sub state_text { $all_states[ shift->state ] }

sub queue {
    my $self = shift;
    $self->job->spider_urls->all;
}

sub q_find {
    my ( $self, $cond ) = @_;
    $self->job->spider_urls->find( $cond ) && 1;
}

sub q_add {
    my ( $self, $entry ) = @_;
    $self->job->create_related( spider_urls => $entry );
}

sub run {
    my $self = shift;
    $self->state(1);
    $self->url_get( URI::URL->new($self->base), $self->depth );
    $self->state(2);
}


sub url_get {
    my ( $self, $url, $depth ) = @_;

    # Delete empty fragments
    $url->fragment(undef) if defined $url->fragment and "" eq $url->fragment;

    # Get a canonical URL
    my $url_text = $url->canonical;

    # Cleanup redundant /./ paths
    $url_text =~ s!/\./!/!g;

    # Make futher cleanup of URL here (when more detergent is available)

    my $mech = AracniUA->new();
    $mech->safe_get($url) or return 0;

    # Reject repeated URLs
    return 0 if $self->q_find({ url => $url_text });

    # Reject repeated content
    my $sum = md5_hex( $mech->binary_content );
    return 0 if $self->q_find({ sum => $sum });

    my $u_rec = $self->q_add( { url => $url_text, sum => $sum, title => $mech->title || $url_text, state => 1 } );

    if ( $depth > 0 ) {
        my @links = $mech->links;
        if (@links) {
            my $l = AracniUrlList->new(
                list => \@links,
                dir  => $self->dir
            );
            $self->add_hyperlinks( $l, $depth - 1 );
        }
    }

    $u_rec->state(2);
    return 1;
}

sub add_hyperlinks {
    my ( $self, $urls, $depth ) = @_;

    my $n = $self->num - 1;
    while ( $n && $urls->list_count ) {
        my $url = $urls->list_next->url_abs;
        next if $self->q_find({ url => "$url" });
        $self->url_get( $url, $depth ) and --$n;
    }
say STDERR "List exausted at level $depth ($n)" if $n;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
