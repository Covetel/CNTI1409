package HTML::FormFu::Validator::CNTI1409::Existe::EntidadUsuario;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';
use utf8;

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};

	if ($params->{'rol'} eq 'administrador'){
		return 1;
	} else {
		my $form = $self->form;
	    my $idev = $c->model('DB::Entidadverificadora')->find( 
			{ "lower(me.nombre)" => lc($value), habilitado => "true" },
	        { columns => [qw / id /] },
		);
	    return 1 if $idev;
	    die HTML::FormFu::Exception::Validator->new({
	        message => 'La Entidad Verificadora no está registrada, por favor dirigirse al menú "Entidades Verificadoras → Registrar"',
	    });
	}
}

1;
