use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CNTI1409' }
BEGIN { use_ok 'CNTI1409::Controller::Auditoria' }

ok( request('/auditoria')->is_redirect, 'Peticion Redireccionada /login' );
done_testing();
