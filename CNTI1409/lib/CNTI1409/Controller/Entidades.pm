package CNTI1409::Controller::Entidades;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Entidades - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto :Private {
    my ( $self, $c ) = @_;
    if ($c->controller eq $c->controller('Root')->action_for('login')) {
        return 1;
    }
    if (!$c->user_exists) {
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }
	$c->assert_user_roles(qw/Administrador/);
    return 1;
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Entidades in Entidades.');
}

=head2 registrar

Este método crea el formulario para registrar entidades verificadoras

=cut

sub registrar : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
	
	# Clases para los campos requeridos. 
	$form->auto_constraint_class( 'constraint_%t' );

    if ($form->submitted_and_valid) { 
        my $entidad = $c->model('DB::Entidadverificadora')->new_result({});
        my $e = $form->model->update($entidad);
		
		use Net::LDAP::Entry;
		my $entry = Net::LDAP::Entry->new;
		# Construyo el DN de la entidad. 
		my $dn = "cn=".$e->nombre.",".$c->config->{base_entidades};
		$entry->dn($dn);
		# Agrego los atributos.
		$entry->add( objectClass => [qw/top posixGroup/], cn => $e->nombre, gidNumber => $e->id);
		my $mesg = $c->model('LDAP')->add($entry);
		if ($mesg->is_error()){
			my $error = 1;
	        $mensaje = "La Entidad " . $form->param_value('nombre') . "no se ha registrado con éxito en LDAP";
		} else {
			my $error = 0;
	        $mensaje = "La Entidad " . $form->param_value('nombre') . " se ha registrado con éxito";
		}
        $c->response->redirect($c->uri_for($self->action_for('registrar'),{ mensaje => $mensaje, error => $error}));
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
		my $label = $form->get_field($err_fields[0])->label; 
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo <span class='strong'> $label </span> ";
    }
    $c->stash->{template} = 'entidades/registrar.tt2';
}

sub listar : Local {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'entidades/listar.tt2';	
} 

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

