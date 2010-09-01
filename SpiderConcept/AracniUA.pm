use utf8;
use feature ":5.10";
use strict;

# My own tailor made UA
package CNTI::Spider::UA;
use Moose;

has ua => (
    is      => "ro",
    builder => "_build_ua",
    handles => { ( map { $_ => $_ } qw(success status is_html title links get head content) ) }
);

use WWW::Mechanize::Cached;

my $cache;

sub _build_ua {
    return $cache->clone if $cache;
    $cache = WWW::Mechanize::Cached->new;
    $cache->env_proxy();
    $cache->agent_alias("Linux Mozilla");
    return $cache;
}

sub safe_get {
    my $self = shift;
    my $url  = shift;
    $self->head($url);
    
    if ( $self->result_is_html ) {
        $self->get($url);
        return $self->result_is_html;
    }
}

sub result_is_html {
    my $self = shift;
    return ($self->success and $self->status ~~ /^200/ and $self->is_html);
}

# Content of response as a binary string because method
# $self->content returns UTF8 strings!
sub binary_content {
    my $self = shift;
    $self->ua->res->content;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
