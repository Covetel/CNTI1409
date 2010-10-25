use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'CNTI1409' }
BEGIN { use_ok 'CNTI1409::Controller::Formularios' }

ok( request('/formularios')->is_redirect, 'Redirecciona a Login' );
done_testing();
