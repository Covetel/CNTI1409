package HTML::FormFu::Validator::CNTI1409::Editar::Unico::EntidadRIF;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';
use utf8;

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};
    my $rs = $c->model('DB::Entidadverificadora')->search( 
		{ "lower(me.rif)" => lc($value) , id => { '!=', $params->{'id'} }}, 
		{ columns => [qw / id /] } 
	);

	return 1 if $rs->count() == 0;

    die HTML::FormFu::Exception::Validator->new({
        message => 'El RIF que está intentando ingresar ya existe',
    });
}

1;
