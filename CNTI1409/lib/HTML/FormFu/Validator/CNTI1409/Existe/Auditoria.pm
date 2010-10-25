package HTML::FormFu::Validator::CNTI1409::Existe::Auditoria;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';
use utf8;

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};

	my $form = $self->form;
	my $institucion = $params->{'idinstitucion'};
	my $idinstitucion = $c->model('DB::Institucion')->find( 
		{ "lower(me.nombre)" => lc($institucion), habilitado => "true" },
	    { columns => [qw / id /] },
	)->id();

	my $portal = $params->{'portal'};
	
	# Busco una auditoria que tenga el mismo nombre de portal y de Institucion y su estado sea Abierta o Pendiente
	my $aud = $c->model('DB::Auditoria')->search({ portal => $portal, idinstitucion => $idinstitucion, -or => [estado => 'a', estado => 'p']});

	if ( $aud->count() > 0 ) {
		die HTML::FormFu::Exception::Validator->new({
			message => 'No es posible registrar dos Auditorias para el mismo portal',
		});
	} else { 1; }
}

1;
