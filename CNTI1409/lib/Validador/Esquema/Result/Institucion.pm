package Validador::Esquema::Result::Institucion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Institucion - Contiene los datos maestros de las instituciones

=cut

__PACKAGE__->table("institucion");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'institucion_id_seq'

Numero de identificacion unica para las instituciones

=head2 nombre

  data_type: 'varchar'
  is_nullable: 0
  size: 250

nombre o Razon Social de la Insitucion

=head2 rif

  data_type: 'varchar'
  default_value: 'N/A'
  is_nullable: 1
  size: 15

Numero Fiscal de la institucion

=head2 correo

  data_type: 'varchar'
  default_value: 'N/A'
  is_nullable: 1
  size: 100

correo Electronico de la institucion

=head2 telefono

  data_type: 'varchar'
  is_nullable: 0
  size: 15

Numero de telefono de la institucion

=head2 contacto

  data_type: 'varchar'
  default_value: 'N/A'
  is_nullable: 1
  size: 250

nombre de la persona contacto en la institucion

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

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "institucion_id_seq",
  },
  "nombre",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "rif",
  {
    data_type => "varchar",
    default_value => "N/A",
    is_nullable => 1,
    size => 15,
  },
  "correo",
  {
    data_type => "varchar",
    default_value => "N/A",
    is_nullable => 1,
    size => 100,
  },
  "telefono",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "contacto",
  {
    data_type => "varchar",
    default_value => "N/A",
    is_nullable => 1,
    size => 250,
  },
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
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idxrifinst", ["rif"]);

=head1 RELATIONS

=head2 auditorias

Type: has_many

Related object: L<Validador::Esquema::Result::Auditoria>

=cut

__PACKAGE__->has_many(
  "auditorias",
  "Validador::Esquema::Result::Auditoria",
  { "foreign.idinstitucion" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-20 11:32:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Af2ChZ9/LBh6tJWbH0viEQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
