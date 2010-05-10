package HTML::FormFu::Validator::CNTI1409::Unico::InstitucionNombre;
#
#===============================================================================
#
#         FILE:  Insitucion.pm
#
#  DESCRIPTION:  Validador de FormFu que verifica si una institucion existe antes
#                de que una auditoria sea creada
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  overdrive (), juan@covetel.com.ve
#      COMPANY:  COVETEL R.S.
#      VERSION:  1.0
#      CREATED:  05/09/10 23:06:07
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use base 'HTML::FormFu::Validator';
use utf8;

sub validate_value {
    my ( $self, $value, $params ) = @_;

    my $c = $self->form->stash->{context};

    my $idinstitucion = $c->model('DB::Institucion')->find(
                                                            { "lower(me.nombre)" => lc($value) },
                                                            { columns => [ qw / id / ] }
                                                          );
    return 1 if !($idinstitucion);

    die HTML::FormFu::Exception::Validator->new({
        message => 'El nombre que esta tratando de ingresar ya existe',
    });
}

1;
