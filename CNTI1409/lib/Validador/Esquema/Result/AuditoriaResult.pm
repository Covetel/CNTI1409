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

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 id_auditoria

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 json

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "id_auditoria",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "json",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

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


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-23 19:38:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UBT0TbvHmoyJQi2viBErwg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
