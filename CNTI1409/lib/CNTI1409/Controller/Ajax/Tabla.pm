package CNTI1409::Controller::Ajax::Tabla;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::REST'; }
__PACKAGE__->config(default => 'application/json');
sub instituciones : Local ActionClass('REST') {}

=head1 NAME

CNTI1409::Controller::Ajax::Tabla - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

=head2 instituciones_GET

Procesa la petición de datos por GET

=cut

sub instituciones_GET {
	my ($self, $c) = @_;
	my $rs = $c->model('DB::Institucion')->search;
	my %data;
	$DB::single=1;
	foreach my $institucion ($rs->all){
		map { $institucion->$_ =~ s/\s+$// } $institucion->columns;
		1;
	}
	#map { [ s/\s+$//g ] } $rs->all;   
    $data{aaData} = [
        map {
            [
                $_->id,        $_->nombre,   $_->rif,
                $_->correo,    $_->telefono, $_->contacto,
                $_->direccion, $_->web,      
            ]
          } $rs->all
    ];

	$self->status_ok($c, entity => \%data);
}

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

