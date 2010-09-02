package CNTI1409::Model::LDAP;

use strict;
use warnings;
use base qw/Catalyst::Model::LDAP/;

__PACKAGE__->config(
    host              => 'localhost',
    base              => 'ou=cnti1409,dc=cnti,dc=gob,dc=ve',
    dn                => 'cn=admin,dc=cnti,dc=gob,dc=ve',
    password          => '123321...',
    start_tls         => 0,
    start_tls_options => { verify => 'require' },
    options           => {},  # Options passed to search
);

=head1 NAME

CNTI1409::Model::LDAP - LDAP Catalyst model component

=head1 SYNOPSIS

See L<CNTI1409>.

=head1 DESCRIPTION

LDAP Catalyst model component.

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
