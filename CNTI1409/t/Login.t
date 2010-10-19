#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use utf8;

use ok "Test::WWW::Mechanize::Catalyst" => "CNTI1409";

# Creo un usuario. 
my $ua = Test::WWW::Mechanize::Catalyst->new; 

$ua->get_ok("http://localhost:3000/", "Probando la URL Base.");
$ua->title_is("CNTI1409", "El titulo es CNTI1409");
$ua->content_contains("Por favor ingrese su usuario y contraseña para ingresar al Sistema","Probar que solicita autenticacion.");

$ua->submit_form(
	fields => {
		correo => 'ucnti',
		password => '12345',
	}, 
	button => 'Botones.submit',
);
$ua->content_contains('Usuario o Contraseña no válidos','Usuario invalido no debe autenticar');

$ua->submit_form(
	fields => {
		correo => 'ucnti',
		password => 'cnti',
	}, 
	button => 'Botones.submit',
);
$ua->content_contains('Bienvenido al sistema','Probando usuario por defecto ucnti, passwd: cnti');

$ua->get_ok('http://localhost:3000/inicio','Probando pagina inicio');
$ua->title_is('CNTI1409','Probando que el titulo sea CNTI1409');
$ua->content_contains('Bienvenido al sistema','Probando que muestre el mensaje de Bienvenida');

done_testing();
