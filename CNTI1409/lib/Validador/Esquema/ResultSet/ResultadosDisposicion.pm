package Validador::Esquema::ResultSet::ResultadosDisposicion;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
use utf8;
use Data::Dumper;
use 5.010;


=head2 pass

Recibe un ID de Job y un nombre de Disposición.
Devuelve verdadero si todas las urls pasaron, 
Devuelve falso si al menos una de las url fallo. 

=cut 

sub pass {
    my ($self, $id, $name) = @_;
    return ! $self->fallo($id, $name);
}

sub paso {
    my ($self, $id, $name) = @_;
    return $self->pass($id, $name);
}

sub fallo {
    my ($self, $id, $name) = @_;
    my @urls = $self->search({name => $name}, { bind => [$id]} );
    for (@urls){
        if ($_->fallo){
            return 1;
        }
    }
    return 0;
}

sub fail {
    my ($self, $id, $name) = @_;
    return $self->fallo($id, $name);
}

=head2 disposiciones

Devuelve una lista de las disposiciones evaluadas para un job
y sus url

=cut 

sub disposiciones {
    my ($self, $id, $disp) = @_;
    my $estado;
    my @urls;
    if ($disp){
        @urls = $self->search({ name => $disp }, {  bind => [$id] });
        $estado = ($self->fallo($id, $disp)) ? 'Falló' : 'Pasó';
    } else {
        @urls = $self->search({ }, { bind => [$id] });
    }

    my $disposiciones;
    my $Disp;

    foreach (@urls){
        $disposiciones->{$_->name} = 'fail';
    }

    foreach my $d (keys %{$disposiciones}){
        $estado = ($self->fallo($id, $d)) ? 'Falló' : 'Pasó';
        my @u_disp = grep { $_->name eq $d } @urls;
        my $urls;
        
        foreach (@u_disp){
           if ($_->fallo){
                push @{$urls->{$_->path}->{mensajes}}, $_->message if $_->message;
           } 
        } 
        my $state = ($estado eq 'Falló') ? 'fail' : 'pass'; 
        $Disp->{$d} = {state => $state, name => $d, estado => $estado, urls => $urls};
    }

    return $Disp;
}

1;
