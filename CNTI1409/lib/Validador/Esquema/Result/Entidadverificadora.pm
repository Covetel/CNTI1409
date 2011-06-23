package Validador::Esquema::Result::Entidadverificadora;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Entidadverificadora - Datos maestros de las Entidades Verificadoras

=cut

__PACKAGE__->table("entidadverificadora");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'entidadverificadora_id_seq'

Numero de identificacion unico para las Entidades Verificadoras

=head2 nombre

  data_type: 'varchar'
  is_nullable: 0
  size: 250

nombre o Razon Social de la Entidad Verificadora

=head2 rif

  data_type: 'varchar'
  is_nullable: 1
  size: 15

Numero fiscal de la Entidad Verificadora

=head2 correo

  data_type: 'varchar'
  is_nullable: 0
  size: 100

correo electronico de la entidad verificadora

=head2 telefono

  data_type: 'varchar'
  is_nullable: 0
  size: 15

Numero de telefono de la Entidad Verificadora

=head2 contacto

  data_type: 'varchar'
  is_nullable: 0
  size: 250

nombre de la persona contacto de la Entidad Verificadora

=head2 direccion

  data_type: 'varchar'
  default_value: 'N/A'
  is_nullable: 1
  size: 500

=head2 web

  data_type: 'varchar'
  default_value: 'N/A'
  is_nullable: 1
  size: 250

=head2 habilitado

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 registro

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Numero de registro de la entidad verificadora

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "entidadverificadora_id_seq",
  },
  "nombre",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "rif",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "correo",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "telefono",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "contacto",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "direccion",
  {
    data_type => "varchar",
    default_value => "N/A",
    is_nullable => 1,
    size => 500,
  },
  "web",
  {
    data_type => "varchar",
    default_value => "N/A",
    is_nullable => 1,
    size => 250,
  },
  "habilitado",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "registro",
  { data_type => "varchar", is_nullable => 1, size => 30 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idxregistro", ["registro"]);
__PACKAGE__->add_unique_constraint("idxrifev", ["rif"]);

=head1 RELATIONS

=head2 auditorias

Type: has_many

Related object: L<Validador::Esquema::Result::Auditoria>

=cut

__PACKAGE__->has_many(
  "auditorias",
  "Validador::Esquema::Result::Auditoria",
  { "foreign.idev" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-20 11:32:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:53J/cHN09YlRjslxsJoexA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
