#!/usr/bin/perl -w
use strict;
use warnings;
use CNTI1409;
use YAML;
use Data::Dumper;

my $config = {};
$config = ({
		});

$config = CNTI1409::Model::DB->config;

print Dump $config;

1;

