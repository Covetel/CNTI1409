package ValidadorCNTI::Controller::Portales::W3C;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use WebService::Validator::HTML::W3C;

=head1 NOMBRE

ValidadorCNTI::Controller::Portales::W3C - Evalua Disposición HTML

=head1 DESCRIPCION

Esta controladora se encarga de validar el código XHTML/HTML de un documento. 

=head1 METODOS

=cut


=head2 index 

Este es el método principal de la controladora. 

=cut
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ValidadorCNTI::Controller::Portales::W3C in Portales::W3C.');
}

=head2 dominio

Verificar si el dominio termina en .gob.ve

=cut
sub dominio : Local {
	my ($self, $c, $url) = @_;
	# contenido
	if ($url =~ /.+\.gob\.ve(|\/)$/) {
		return 1;
	} else {
		return 0;
	}
}

=head2 html

Verificar contra W3C si es valida la maquetacion

=cut
sub html : Local {
	my ($self, $c, $url) = @_;
	$DB::single = 1;
	my $v = WebService::Validator::HTML::W3C->new(detailed => 1);
	if (defined($url)) {
		$url = $self->fixurl($url);
		$v->validate($url) or warn ("No se pudo validar el sitio");
		if ($v->is_valid) {
        		return 1;
		} else {	
        		#return @{$v->errors};
        		return 0;
		}
	} else {
		return 0;
	}
}

=head2 fixurl

Metodo privado para arreglar la URL pasada

=cut
sub fixurl : Private {
	my ($c, $url) = @_;
	$url = "http://" . $url if !($url=~/^(http(|s)):\/\//);
	return $url;
}


=head1 AUTHOR

Cooperativa Venezolana de Tecnologías Libres R.S. <info@covetel.com.ve>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
