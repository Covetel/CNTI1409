package Validador::Esquema::Result::ResultadosDisposicion;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('resultadosxdisposicion');
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(
"SELECT j.id as jobid, path, name, pass, class, message FROM jobs j LEFT JOIN
urls u ON j.id = u.pid LEFT JOIN results re ON u.id = re.pid LEFT JOIN events
ev ON re.id = ev.pid WHERE j.id = ?"
);

__PACKAGE__->add_columns(
    'jobid' => {
        data_type => 'integer', 
    }, 
    'path' => {
        data_type => 'varchar', 
    },
    'name' => {
        data_type => 'varchar', 
    },
    'pass' => {
        data_type => 'varchar', 
    },
    'class' => {
        data_type => 'varchar', 
    },
    'message' => {
        data_type => 'varchar', 
    },
);

sub paso {
    my $self = shift;
    return ($self->pass eq 'pass') ? 1 : 0;
}

sub fail {
    my $self = shift;
    return 1 if $self->pass eq 'fail';
}

sub fallo {
    my $self = shift;
    return $self->fail;
}

1;
