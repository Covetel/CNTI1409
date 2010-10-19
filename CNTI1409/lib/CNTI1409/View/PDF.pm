package CNTI1409::View::PDF;

use strict;
use warnings;

use base 'Catalyst::View::TT';
use CNTI1409;

__PACKAGE__->config({
	TEMPLATE_EXTENSION => '.tt2',
	ENCODING     => 'UTF-8',
    CATALYST_VAR => 'c',
	INCLUDE_PATH => [
        CNTI1409->path_to( 'root', 'src', 'reportes' ),
        CNTI1409->path_to( 'root', 'src'),
	],

});

=head1 NAME

CNTI1409::View::PDF - TT View for CNTI1409

=head1 DESCRIPTION

TT View for CNTI1409.

=head1 SEE ALSO

L<CNTI1409>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
