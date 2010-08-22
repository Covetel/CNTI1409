#!/usr/bin/perl -w
use strict;
use warnings;
use lib qw(blib/lib blib/arch lib);
use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;
use common::sense;
use Data::Dumper;

sub disposiciones {
	my ( $job_id ) = @_;
	my $j = CNTI::Validator::Jobs->find_job($job_id);
	my $it = $j->children;
	my $disp = {};
	while ( my $u = $it->() ) {
		my $it2 = $u->children;
		while (my $r = $it2->()){
			$disp->{$r->name}->{result} = 'pass';
			$disp->{$r->name}->{name} = $r->name;
			my $url = $u->path; 
			$url =~ s/\s//gi;
			$url =~ s/\r//gi;
			$disp->{$r->name}->{urls}->{$url} = { result => $r->pass};
			$disp->{$r->name}->{result} = $r->pass if $r->pass eq 'fail';
			my $it3 = $r->children;
			while (my $m = $it3->()){
				$disp->{$r->name}->{urls}->{$url}->{mensajes} = $m->message;
			}
		}
	}
	return $disp;
}

my $disp = disposiciones 9;
print Dumper($disp);
