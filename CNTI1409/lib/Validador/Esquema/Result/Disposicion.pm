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

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'disposicion_id_seq'

Numero de identificacion unica de la disposicion

=head2 nombre

  data_type: 'varchar'
  is_nullable: 0
  size: 25

nombre de la disposicion

=head2 descripcion

  data_type: 'text'
  is_nullable: 0

Descripcion de la disposicion

=head2 habilitado

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion

=head2 modulo

  data_type: 'varchar'
  is_nullable: 1
  size: 10

Nombre del modulo que ejecuta el Job en el sistema

=head2 descripcion_prueba

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "disposicion_id_seq",
  },
  "nombre",
  { data_type => "varchar", is_nullable => 0, size => 25 },
  "descripcion",
  { data_type => "text", is_nullable => 0 },
  "habilitado",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "modulo",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "descripcion_prueba",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idxmodulo", ["modulo"]);
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
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-20 11:32:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WEUoPIiUm3tzXCUJvlADKQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
