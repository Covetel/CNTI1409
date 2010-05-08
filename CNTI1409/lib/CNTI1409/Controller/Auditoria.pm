package CNTI1409::Controller::Auditoria;
use Moose;
use namespace::autoclean;
use DateTime;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

CNTI1409::Controller::Auditoria - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CNTI1409::Controller::Auditoria in Auditoria.');
}

=head2 crear

=cut

sub crear : Local : FormConfig {
    my ( $self, $c, $mensaje, $error ) = @_;
    $c->stash->{mensaje} = $c->req->params->{mensaje};
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        my $upload = $c->request->upload('Examinar');
        my $pop = $upload->filename;
        my $archivo = "/tmp/$pop";
        $upload->copy_to($archivo);
        open ARCHIVO, "<encoding(UTF-8)", $archivo;
        my @portales = <ARCHIVO>;
        my $idinstitucion = $c->model('DB::Institucion')->find(
                                                                { "lower(me.nombre)" => lc($c->req->params->{idinstitucion})},
                                                                { columns => [ qw / id / ] }
                                                              );
        my $idev = $c->model('DB::Entidadverificadora')->find(
                                                                { "lower(me.nombre)" => lc($c->req->params->{idev})},
                                                                { columns => [ qw / id / ] }
                                                            );

        if ($idinstitucion && $idev) {
            $c->model('DB::Auditoria')->create({
                                                   idev            => $idev,
                                                   idinstitucion   => $idinstitucion,
                                                   portal          => $c->req->params->{portal},
                                                   fechacreacion   => DateTime->now,
                                                   url             => \@portales,
                                               });
            $mensaje = "La auditoría se ha registrado con éxito";
            $c->response->redirect($c->uri_for($self->action_for('crear'),{ mensaje => $mensaje, error => 0}));
        } else {
            $c->stash->{error} = 1;
            my @err_fields = $form->has_errors;
            $c->stash->{mensaje} = "Verifique la institucion o entidad verificadora, los datos no coinciden... ";
        }
	} elsif ($form->has_errors && $form->submitted) {
        $c->stash->{error} = 1;
        my @err_fields = $form->has_errors;
        $c->stash->{mensaje} = "Ha ocurrido un error en el campo $err_fields[0] ";
    }
    $c->stash->{template} = 'auditoria/crear.tt2';
}

=head2 listar

Carga la template con la tabla HTML preparada. 

=cut 

sub reporte : Local {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'auditoria/listar.tt2';	
} 

=head1 AUTHOR

Walter Vargas <walter@covetel.com.ve>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

