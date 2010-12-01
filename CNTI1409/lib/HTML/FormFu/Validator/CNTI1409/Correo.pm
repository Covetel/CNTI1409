package HTML::FormFu::Validator::CNTI1409::Correo;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';
use utf8;

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};
	my $campo = 'correo';
	my ($rs, $rs2);
	if ($params->{'id'}){
    	$rs = $c->model('DB::Entidadverificadora')->search( 
			{ "lower(me.$campo)" => lc($value) , id => { '!=', $params->{'id'} }}, 
			{ columns => [qw / id /] } 
		);
    	$rs2 = $c->model('DB::Institucion')->search( 
			{ "lower(me.$campo)" => lc($value) , id => { '!=', $params->{'id'} }}, 
			{ columns => [qw / id /] } 
		);
	} else {
    	$rs = $c->model('DB::Entidadverificadora')->search( 
			{ "lower(me.$campo)" => lc($value)}, 
			{ columns => [qw / id /] } 
		);
    	$rs2 = $c->model('DB::Institucion')->search( 
			{ "lower(me.$campo)" => lc($value)}, 
			{ columns => [qw / id /] } 
		);
	} 
	
	if ($rs->count() == 0 && $rs2->count() == 0) {
		return 1;
	}

    die HTML::FormFu::Exception::Validator->new({
        message => 'El Correo que está intentando ingresar pertenece a otro registro',
    });
}

1;
