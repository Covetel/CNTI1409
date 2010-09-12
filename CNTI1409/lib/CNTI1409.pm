package CNTI1409;
use Moose;
use utf8;
use namespace::autoclean;

our $VERSION = '0.3';
$VERSION = eval $VERSION;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
	Unicode::Encoding
    Authentication
	Authorization::Roles
    Session
    Session::Store::FastMmap
    Session::State::Cookie
	Breadcrumbs
/;

extends 'Catalyst';

__PACKAGE__->config(
	'Plugin::ConfigLoader' => { file => 'configuracion.yml' },
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

CNTI1409 - Sistema para la Automatización del protocolo de prueba de portales de Internet 

=head1 SYNOPSIS

    script/cnti1409_server.pl

=head1 DESCRIPTION

=head2 Antecedentes

Desde el año 1994 la W3C ha sido el órgano encargado de establecer recomendaciones, normas y estándares para Internet, a fin de conseguir una estandarización mundial. El Centro Nacional de Tecnologías de Información, CNTI, por su parte, ha aunado esfuerzos con el objetivo de crear un marco transparente y confiable que articule la generación de normas técnicas y procesos de certificación que garanticen el cumplimiento de los lineamientos ya establecidos, sumando los estatutos del Ministerio del Poder Popular para Comunicación e Información (Minci) y el Ministerio del Poder Popular para Ciencia, Tecnología e Industrias Intermedias.

=head2 Justificación

El Centro Nacional de Tecnologías de Información, CNTI, ha asumido nuevas responsabilidades en el marco del desarrollo tecnológico nacional. Una de estas responsabilidades es el impulso de la adopción de estándares de Tecnologías de Información (TI) en la administración pública. Para dar respuesta a esta situación, es necesario automatizar los proceso relacionados a la generación y mantenimiento de normas referidas a las tecnologías de información. Así como la aplicación del decreto 3.390 y la modernización de la infraestructura del resto de las instituciones públicas, que exigen un mayor número de profesionales y entes certificados en servicios tecnológicos en el desarrollo y mantenimiento de aplicaciones informáticas, por ello es necesario la optimización del protocolo de prueba de verificación de los portales de Internet, con las disposiciones contenidas en la Norma Técnica de Portales de Internet, de forma que facilite la gestión del proceso de auditoría para la certificación. 

=head1 SEE ALSO

L<CNTI1409::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Cooperativa Venezolana de Tecnologías Libres - <info@covetel.com.ve>

=head1 SOURCE

Las fuentes de este programa se encuentran disponibles en nuestro repositorio Git
ubicado en L<http://git.covetel.com.ve/CNTI-14-09.git>

=head1 BUGS

Todo el software de cieta complejidad puede contener errores, si consigues
algún error en este código por favor reportalo a: L<mailto:info@covetel.com.ve>

Nos sería de mucha ayuda si además de reportar el error puedes hacer un caso
de prueba que identifique el problema y adjuntarlo al reporte del error.

=head1 COPYRIGHT

Copyright 2010 by Cooperativa Venezolana de Tecnologías Libres R.S. <info@covetel.com.ve>

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

Este programa es software libre; lo puedes redistribuir y modificar en los
mismos términos que las fuentes de Perl.

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

Este programa es software libre; lo puedes redistribuir y modificar en los
mismos términos que las fuentes de Perl.

=cut

1;
