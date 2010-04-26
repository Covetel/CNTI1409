package ValidadorCNTI::View::TTClean;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    CATALYST_VAR => 'Catalyst',
    INCLUDE_PATH => [
        ValidadorCNTI->path_to( 'root', 'src' ),
        ValidadorCNTI->path_to( 'root', 'lib' )
    ],
    ERROR        => 'error.tt2',
    TIMER        => 0
});

=head1 NAME

ValidadorCNTI::View::TTClean - TT View for ValidadorCNTI

=head1 DESCRIPTION

TT View for ValidadorCNTI. 

=head1 AUTHOR

=head1 SEE ALSO

L<ValidadorCNTI>

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
