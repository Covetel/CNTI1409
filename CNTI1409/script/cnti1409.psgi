#!/usr/bin/env perl
use strict;

use Plack::Builder;
use CNTI1409;

CNTI1409->setup_engine('PSGI');
my $app = sub { CNTI1409->run(@_) };

builder {
    enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1' }
        "Plack::Middleware::ReverseProxy";
    $app;
};
