package Validador::Esquema::Result::Disposicion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Disposicion - Contiene los datos sobre las disposiciones

=cut

__PACKAGE__->table("disposicion");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: SCALAR(0x99a9198)
  is_auto_increment: 1
  is_nullable: 0

Numero de identificacion unica de la disposicion

=head2 nombre

  data_type: character varying
  default_value: undef
  is_nullable: 0
  size: 25

nombre de la disposicion

=head2 descripcion

  data_type: character varying
  default_value: undef
  is_nullable: 0
  size: 100

Descripcion de la disposicion

=head2 habilitado

  data_type: boolean
  default_value: SCALAR(0x99aa720)
  is_nullable: 0

Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('disposicion_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "nombre",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 25,
  },
  "descripcion",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "habilitado",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idxnombredisp", ["nombre"]);

=head1 RELATIONS

=head2 auditoriadetalles

Type: has_many

Related object: L<Validador::Esquema::Result::Auditoriadetalle>

=cut

__PACKAGE__->has_many(
  "auditoriadetalles",
  "Validador::Esquema::Result::Auditoriadetalle",
  { "foreign.iddisposicion" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-05-06 07:49:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l3dZBMF+gptMplEMr0rgeQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
