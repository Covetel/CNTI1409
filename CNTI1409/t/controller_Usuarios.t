use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CNTI1409' }
BEGIN { use_ok 'CNTI1409::Controller::Usuarios' }

ok( request('/usuarios')->is_success, 'Request should succeed' );
done_testing();