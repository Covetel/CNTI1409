use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CNTI1409' }
BEGIN { use_ok 'CNTI1409::Controller::Ajax::Spider' }

ok( request('/ajax/spider')->is_success, 'Request should succeed' );
done_testing();
