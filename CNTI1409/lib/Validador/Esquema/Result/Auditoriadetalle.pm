package Validador::Esquema::Result::Auditoriadetalle;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Auditoriadetalle

=head1 DESCRIPTION

Almacena los detalles de una auditoria, sobre todo los resultados de las disposiciones por portal

=cut

__PACKAGE__->table("auditoriadetalle");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'auditoriadetalle_id_seq'

Numero de identificacion unica para los detalles de las auditorias

=head2 idauditoria

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Clave que relaciona los detalles de la auditoria con sus datos maestros

=head2 iddisposicion

  data_type: 'bigint'
  is_auto_increment: 1
  is_foreign_key: 1
  is_nullable: 0
  sequence: 'auditoriadetalle_iddisposicion_seq'

Clave que relaciona los detalles de las auditorias con cada disposicion

=head2 resolutoria

  data_type: 'varchar'
  is_nullable: 1
  size: 200

resolutoria del auditor por cada disposicion evaluada a un portal

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "auditoriadetalle_id_seq",
  },
  "idauditoria",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "iddisposicion",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_foreign_key    => 1,
    is_nullable       => 0,
    sequence          => "auditoriadetalle_iddisposicion_seq",
  },
  "resolutoria",
  { data_type => "varchar", is_nullable => 1, size => 200 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 iddisposicion

Type: belongs_to

Related object: L<Validador::Esquema::Result::Disposicion>

=cut

__PACKAGE__->belongs_to(
  "iddisposicion",
  "Validador::Esquema::Result::Disposicion",
  { id => "iddisposicion" },
  {},
);

=head2 idauditoria

Type: belongs_to

Related object: L<Validador::Esquema::Result::Auditoria>

=cut

__PACKAGE__->belongs_to(
  "idauditoria",
  "Validador::Esquema::Result::Auditoria",
  { id => "idauditoria" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-20 11:31:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:go1OhC55L5b4jqp8/zw6Ew


# You can replace this text with custom content, and it will be preserved on regeneration
1;
