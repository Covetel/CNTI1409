package CNTI1409::View::VistaPrincipal;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    CATALYST_VAR => 'c',
    INCLUDE_PATH => [
        CNTI1409->path_to( 'root', 'src' ),
        CNTI1409->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    TIMER        => 0
});
 

=head1 NAME

CNTI1409::View::VistaPrincipal - Catalyst TTSimple View

=head1 SYNOPSIS

See L<CNTI1409>

=head1 DESCRIPTION

Catalyst TTSimple View.

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

