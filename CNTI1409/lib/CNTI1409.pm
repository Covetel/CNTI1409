package CNTI1409;
use Moose;
use utf8;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
	-Debug
    ConfigLoader
    Static::Simple
	Unicode::Encoding
	StackTrace
    Authentication
    Session
    Session::Store::FastMmap
    Session::State::Cookie
	Breadcrumbs
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in cnti1409.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
	'Plugin::ConfigLoader' => { file => 'configuracion.yml' },
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

CNTI1409 - Catalyst based application

=head1 SYNOPSIS

    script/cnti1409_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<CNTI1409::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
