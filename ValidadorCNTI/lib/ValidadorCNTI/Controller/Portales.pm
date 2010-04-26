package ValidadorCNTI::Controller::Portales;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NOMBRE

ValidadorCNTI::Controller::Portales - Controladora Portales.

=head1 DESCRIPCION

Esta controladora se encarga de validar todas las disposiciones de la norma. 
A medida que se vallan programando, seran creadas controladoras hijas de esta,
que serán responsables de automatizar cada disposición. 

=head1 METODOS

=cut

=head2 index 

Este es el método principal de la controladora. 

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
}

=head2 upload 

Este es el método encargado de subir el archivo sitios.txt al sistema. 

=cut

sub upload : Local {
    my ( $self, $c ) = @_;
    if ( $c->request->parameters->{form_submit} eq 'yes' ) {
        $c->stash->{mensaje} =
          'La lista de Portales ha sido cargada exitosamente.';
        if ( my $upload = $c->request->upload('my_file') ) {
            my $filename = $upload->filename;
            my $target   = "/tmp/$filename";
            unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
                die("Failed to copy '$filename' to '$target': $!");
            }
        }
    }
    else {
        $c->stash->{mensaje} =
          'Debe cargar un archivo llamado sitios.txt con la lista de portales.';
    }
    $c->stash->{template} = 'Portales/upload.tt2';

}

=head2 validar 

Este es el método encargado de despachar las disposiciones de la norma. 

=cut

sub validar : Local {

    my ( $self, $c ) = @_;
    if ( $c->req->method eq 'GET' ) {
        $c->stash->{portales} = [ $self->portales ];
        $c->stash->{template} = 'Portales/validar.tt2';
    }
    elsif ( $c->req->method eq 'POST' ) {
        my @portales = $c->req->param('portales');
        my @p;
        foreach my $portal (@portales) {
            my %criterios = (
                Dominio => {
                    descripcion => 'Disposición 3.1 del protocolo de pruebas',
                    cumple      => undef,
                    detalle     => undef
                },
                HTML => {
                    descripcion => 'Disposición 3.2 del protocolo de pruebas',
                    cumple      => undef,
                    detalle     => undef
                },
                CSS => {
                    descripcion => 'Disposición 3.8 del protocolo de pruebas',
                    cumple      => undef,
                    detalle     => undef
                }
            );
            my $h = { nombre => $portal, cumple => undef, id => $portal };

            # Evaluo los criterios.
            foreach my $criterio ( keys %criterios ) {

# El método de la controladora que evalua el criterio es el nombre del criterio en minuscula
                my $metodo = lc $criterio;
                next if ( $metodo eq 'css' );

             # Por ahora la controladora que evalua el criterio es la siguiente:
                my $controller = 'ValidadorCNTI::Controller::Portales::W3C';
                my $r = $c->forward( $controller, $metodo, [$portal] );
                $criterios{$criterio}->{'cumple'} = 'SI' if $r;
                $criterios{$criterio}->{'cumple'} = 'NO' unless $r;
                $h->{ lc $criterio } = lc $criterios{$criterio}->{'cumple'};
            }

        # Evaluo el resultado de los criterios, para definir el resultado final.
            my $criterios_cumple = '-';
            foreach my $criterio ( keys %criterios ) {
                $criterios_cumple .= $criterios{$criterio}->{'cumple'}
                  || 'No se pudo evaluar';
            }
            if ( $criterios_cumple =~ m/NO/ ) {
                $h->{'cumple'} = 'NO';
            }
            else {
                $h->{'cumple'} = 'SI';
            }
            $h->{'criterios'} = \%criterios;
            push @p, $h;
        }
        $self->reportePDF( $self, @p );
        $c->stash->{portales} = [@p];
        $c->stash->{template} = 'Portales/reporte.tt2';
    }
}

=head2 reportePDF 

Este es el método encargado de generar el reporte PDF.

=cut

sub reportePDF : Local {
    my ( $self, $c, @portales ) = @_;
    my $logo =
      ValidadorCNTI->path_to( 'root', 'static', 'images', 'logo_cnti.jpeg' );
    use Template;
    my $template = Template->new(
        {
            INCLUDE_PATH => ValidadorCNTI->path_to( 'root', 'src', 'Portales' ),
            OUTPUT_PATH => ValidadorCNTI->path_to( 'root', 'static', 'pdf' ),
        }
    );
    foreach my $portal (@portales) {
        my $vars = {
            portal  => $portal->{'nombre'},
            logo    => $logo,
            cumple  => $portal->{'cumple'},
            dominio => $portal->{'criterios'}->{'Dominio'}->{'cumple'},
            html    => $portal->{'criterios'}->{'HTML'}->{'cumple'},
        };
        my $nombre = $portal->{'nombre'};
        my $tex    = "/$nombre.tex";
        $template->process( 'plantilla.tt2', $vars, $tex )
          || die $template->error();
        my $path  = ValidadorCNTI->path_to( 'root', 'static', 'pdf' );
        my $path2 = ValidadorCNTI->path_to( 'root', 'static', 'pdf' );
        my $file = $path .= $tex;
        my @args = ( "/usr/bin/pdflatex", "-output-directory", $path2, $file );
        system(@args);
        system(@args);
    }
    1;
}

=head2 portales 

Este es el método devuelve la lista de portales a chequear. 
Por ahora salen de un archivo en /tmp llamado sitios.txt

=cut

sub portales {
    open PORTALES, "<:encoding(UTF-8)", "/tmp/sitios.txt";
    my @portales = <PORTALES>;
    map { chomp } @portales;
    return @portales;
}

=head1 AUTHOR

Cooperativa Venezolana de Tecnologías Libres R.S. <info@covetel.com.ve>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.
=cut

1;
