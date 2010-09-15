package CNTI1409::LDAP::Entrada; 
use base qw/Catalyst::Model::LDAP::Entry/;
use Config::Any::YAML;

# Cargo mi configuración. 
my $config = Config::Any::YAML->load("configuracion.yml");

=head1 NOMBRE

CNTI1409::LDAP::Entrada

=head1 DESCRIPCION 

Modelo basada en LDAP, principalmente contiene métodos que hacen mas fácil la gestión de roles de los usuarios
y sus respectivas pertenencias a Entidades Verificadoras. 

=head1 METODOS 

=head2 roles()

Retorna un array con los roles del usuario. 

=cut

sub roles {
	my ($self) = @_;
	# Busco los roles que posee el usuario. 
	my $ldap = $self->_ldap_client();
	my $uid = $self->uid;
	my @entradas = $ldap->search( 
			base 	=> $config->{base_roles},
			filter 	=> "(&(objectClass=posixGroup)(memberUid=".$uid."))"
	)->entries();
	my @roles; 

	foreach my $entrada (@entradas){
		my $cn = $entrada->cn;
		push @roles,$cn;
	}	

	return @roles;
}

=head2 check_role

Recibe una cadena con el nombre del rol.
Retorna 1 si el rol se encuentra en la lista de roles. 

=cut 

sub check_role {
	my ($self, $role) = @_;
	my @roles = $self->roles();
	foreach my $r (@roles){
		return 1 if $r eq $role;
	}
	return undef;
}

=head2 is_administrador

Retorna un valor verdadero si el usuario tiene el rol administrador. 

=cut

sub is_administrador {
	my ($self) = @_;
	my $r = $self->check_role("Administrador");
	return $r;
}

=head2 is_auditorJefe

Retorna un valor verdadero si el usuario tiene el rol Auditor Jefe.

=cut

sub is_auditorJefe {
	my ($self) = @_;
	my $r = $self->check_role("AuditorJefe");
	return $r;
}


=head2 is_auditor

Retorna un valor verdadero si el usuario tiene el rol Auditor.

=cut

sub is_auditor {
	my ($self) = @_;
	my $r = $self->check_role("Auditor");
	return $r;
}

=head2 delete 

Borra un usuario del LDAP. 

=cut

sub delete {
	my ($self) = @_;
	my $ldap = $self->_ldap_client();
	
	# Elimino la pertenencia del usuario a los roles. 
	my @roles = $ldap->search(
		base => $config->{base_roles},
		filter => "(&(objectClass=posixGroup)(memberUid=".$self->uid."))",
	)->entries();
	foreach my $rol (@roles){
		if ($rol->exists("memberUid")) {
			my @newuids;
			my @uids = $rol->memberUid;
			foreach my $u (@uids){
				push @newuids, $u if $u ne $self->uid;
			}
			$rol->replace(memberUid => \@newuids);
			$rol->update();
		}
	}

	# Elimino la pertenencia del usuario a la entidad verificadora.
	my $entidad = $ldap->search(
		base => $config->{base_entidades},
		filter => "(&(objectClass=posixGroup)(memberUid=".$self->uid."))",
	)->shift_entry();
	if ($entidad && $entidad->exists("memberUid")) {
		my @newuids;
		my @uids = $entidad->memberUid;
		foreach my $u (@uids){
			push @newuids, $u if $u ne $self->uid;
		}
		$entidad->replace(memberUid => \@newuids);
		$entidad->update();
	}

	# Elimino el usuario del LDAP. 
	my $mesg = $ldap->delete($self->dn());

}

=head2 entidad_verificadora

Busca la entidad verificadora en LDAP. 

=cut 

sub entidad_verificadora {
	my ($self) = @_;
	my $ldap = $self->_ldap_client();
	my $entidad = $ldap->search(
		base => $config->{base_entidades},
		filter => "(&(objectClass=posixGroup)(memberUid=".$self->uid."))",
	)->shift_entry();
	if ($entidad){
		return $entidad;
	} else {
		return undef;
	}
}

1;
