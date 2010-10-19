use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CNTI1409' }
BEGIN { use_ok 'CNTI1409::Controller::Ajax::Usuario' }

ok( request('/ajax/usuario')->is_redirect, 'Redirecciona a Login' );
done_testing();
