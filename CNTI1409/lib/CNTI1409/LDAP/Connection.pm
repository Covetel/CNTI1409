package CNTI1409::LDAP::Connection;
use base qw/Catalyst::Model::LDAP::Connection/;
use Config::Any::YAML;

# Cargo mi configuración. 
my $config = Config::Any::YAML->load("configuracion.yml");

=head1 NOMBRE

CNTI1409::LDAP::Connection

=head1 DESCRIPCION 

Modelo basada en LDAP.

=head1 METODOS 

=head2 usuario 

Recibe el UID de busqueda del usuario, y retorna una entrada Net::LDAP::Entry correspondiente o undef. 

=cut 

sub usuario {
	my ($self,$uid) = @_;
	my $usuario = $self->search(
		base => $config->{base_usuarios},
		filter => "(&(objectClass=posixAccount)(uid=".$uid."))"
	)->shift_entry;
	if ($usuario){
		return $usuario;
	} else {
		return undef;
	}
}

=head2 user_exists ($uid)

Recibe $uid, devuelve 1 si $uid existe en el LDAP.

=cut 


sub user_exists {
	my ( $self, $uid) = @_;
	my $count = $self->search( 
			base 	=> $config->{base_usuarios},
			filter 	=> "(&(objectClass=posixAccount)(uid=".$uid."))"
	)->count();
	return $count;
}


