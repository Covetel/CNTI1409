#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use utf8;

use ok "Test::WWW::Mechanize::Catalyst" => "CNTI1409";

# Creo un usuario. 
my $ua = Test::WWW::Mechanize::Catalyst->new; 

$ua->get_ok("http://localhost:3000/login", "Ir a la pagina de login.");
$ua->submit_form(
	fields => {
		correo => 'ucnti',
		password => 'cnti',
	}, 
	button => 'Botones.submit',
);
$ua->content_contains('Bienvenido al sistema','Probando usuario por defecto ucnti, passwd: 1234');

$ua->get_ok("http://localhost:3000/auditoria/crear", "Probando la URL Base de Crear Auditoria.");
$ua->content_contains("Por favor ingrese el nombre de la Institución correctamente.","Se obtiene el formualrio Crear Auditoria");

$ua->submit_form(
	fields => {
		idinstitucion => 'Centro Nacional de Tecnologías de Información',
		idev => 'Cooperativa Venezolana de Tecnologías Libres R.S.',
		portal => 'Prueba WWW::Mechanize',
		Examinar => 't/muestra.txt',
	}, 
	button => 'Botones.submit',
);

$ua->content_contains('La auditoría se ha registrado con éxito','Auditoria Registrada con exito');
$ua->save_content('/tmp/x.html');

done_testing();
