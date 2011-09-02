package Validador::Esquema::Result::AuditoriaResult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::AuditoriaResult - Almacena los resultados de la auditoria serializados en JSON

=cut

__PACKAGE__->table("auditoria_result");

=head1 ACCESSORS

=head2 id_auditoria

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 json

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'auditoria_result_id_seq'

=cut

__PACKAGE__->add_columns(
  "id_auditoria",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "json",
  { data_type => "text", is_nullable => 1 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "auditoria_result_id_seq",
  },
);

=head1 RELATIONS

=head2 id_auditoria

Type: belongs_to

Related object: L<Validador::Esquema::Result::Auditoria>

=cut

__PACKAGE__->belongs_to(
  "id_auditoria",
  "Validador::Esquema::Result::Auditoria",
  { id => "id_auditoria" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-01 20:19:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qzFtOkG/Egg94nVYuJN0Cg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 to_json 

Recibe el hash y lo serializa a json.

=cut 
    

use JSON::XS;

sub to_json {
    my $self = shift;
    my $json = encode_json $self->json;
    return $json;
}

sub json {
    my $self = shift;
    my $json = decode_json $self->json;
    return $json;
}

1;
