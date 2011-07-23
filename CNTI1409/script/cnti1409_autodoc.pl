#!/usr/bin/env perl
use strict;
use warnings;
use DBICx::AutoDoc;
use lib qw/lib/;

my $ad = DBICx::AutoDoc->new(
    schema => 'Validador::Esquema',
    output => '/tmp', 
);

$ad->fill_template('html');
