use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'ValidadorCNTI' }
BEGIN { use_ok 'ValidadorCNTI::Controller::Portales' }

ok( request('/portales')->is_success, 'Request should succeed' );


