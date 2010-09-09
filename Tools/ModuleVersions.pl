#!/usr/bin/perl -w
use strict;
use warnings;
use CPAN;
use Template;

my $tt2 = 'Makefile.PL.tt2';
my $vars;

my $config = {
               INTERPOLATE  => 0,               # expand "$var" in plain text
               POST_CHOMP   => 1,               # cleanup whitespace
               EVAL_PERL    => 0,               # evaluate Perl code blocks
           };

my $template = Template->new($config);

# Leo las dependencias
open FILE, '<', 'Dependencias.txt';
my @modulos = <FILE>;

my @m;
foreach my $module (@modulos){
	chomp($module);
	foreach my $mod (CPAN::Shell->expand("Module", $module)){
		my $modulo = {};
		$modulo->{id} = $mod->id;		
		$modulo->{version} = $mod->inst_version;
		push @m,$modulo;
	}
}

$vars->{modules} = \@m;

$template->process($tt2, $vars, 'Makefile.PL');

=head1 NAME 

ModuleVersions - Calcula la versión de los módulos de Perl que estoy usando. 

=head1 DESCRIPCION

Es necesario especificar la versión de cada módulo que estoy usando en Makefile.PL
para esto necesito generar la salida de ese fichero al vuelo con las versiones especificas 
de las dependencias. 

=head1 AUTOR

Walter Vargas <walter@covetel.com.ve>

=cut 


