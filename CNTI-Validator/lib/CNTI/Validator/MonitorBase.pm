package CNTI::Validator::MonitorBase;
use Moose;

has _record => ( is => "ro", required => 1 );

around BUILDARGS => sub {
    my $orig   = shift;
    my $class  = shift;
    my $record = shift;
    $class->$orig( $record->get_columns, _record => $record );
};

sub refresh {
    my $self = shift;
    my $rec  = $self->_record;
    $rec->discard_changes();

    # Cheat, low level hack, interface violation but quick :-) XXX
    %$self = $rec->get_columns;
}

sub children {
    my $self = shift;
    my $rs = $self->_record->search_related( $self->child_class->table, @_ );

    # Making a proper Moose iterator will take some time so ...
    return sub { $self->child_class->new( $rs->next ) };
}

sub add_children {
    my $self   = shift;
    my $rec    = $self->_record;
    my $childc = $self->child_class;
    my $childt = $childc->model_class->table;
    $rec->create_related( $childt, $_ ) for @_;
}

sub parent {
    my $self = shift;
    $self->_record->search_related( $self->child_class->table, );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

