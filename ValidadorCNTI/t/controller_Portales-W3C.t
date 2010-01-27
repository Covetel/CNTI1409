use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'ValidadorCNTI' }
BEGIN { use_ok 'ValidadorCNTI::Controller::Portales::W3C' }

ok( request('/portales/w3c')->is_success, 'Request should succeed' );


