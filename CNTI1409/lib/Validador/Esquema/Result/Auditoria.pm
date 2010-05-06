package Validador::Esquema::Result::Auditoria;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Auditoria

=head1 DESCRIPTION

Almacena los datos de las auditorias, aqui se registran los datos de los portales.

=cut

__PACKAGE__->table("auditoria");

=head1 ACCESSORS

=head2 id

  data_type: bigint
  default_value: SCALAR(0x9885828)
  is_auto_increment: 1
  is_nullable: 0

Numero de identificacion unica de las auditorias

=head2 idev

  data_type: bigint
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0

Clave de relacion entre las entidades verificadoras y las auditorias

=head2 idinstitucion

  data_type: bigint
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0

Clave que relaciona las instituciones con las auditorias

=head2 portal

  data_type: character varying
  default_value: undef
  is_nullable: 0
  size: 100

Almacena el nombre del portal a auditar

=head2 fechaini

  data_type: date
  default_value: undef
  is_nullable: 0

Fecha de inicio de la auditoria

=head2 fechafin

  data_type: date
  default_value: undef
  is_nullable: 1

Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada

=head2 url

  data_type: text
  default_value: undef
  is_nullable: 0

Almacena el listado de las url a auditar en un portal

=head2 fechacreacion

  data_type: date
  default_value: undef
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    default_value     => \"nextval('auditoria_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "idev",
  {
    data_type      => "bigint",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "idinstitucion",
  {
    data_type      => "bigint",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "portal",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "fechaini",
  { data_type => "date", default_value => undef, is_nullable => 0 },
  "fechafin",
  { data_type => "date", default_value => undef, is_nullable => 1 },
  "url",
  { data_type => "text", default_value => undef, is_nullable => 0 },
  "fechacreacion",
  { data_type => "date", default_value => undef, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 idev

Type: belongs_to

Related object: L<Validador::Esquema::Result::Entidadverificadora>

=cut

__PACKAGE__->belongs_to(
  "idev",
  "Validador::Esquema::Result::Entidadverificadora",
  { id => "idev" },
  {},
);

=head2 idinstitucion

Type: belongs_to

Related object: L<Validador::Esquema::Result::Institucion>

=cut

__PACKAGE__->belongs_to(
  "idinstitucion",
  "Validador::Esquema::Result::Institucion",
  { id => "idinstitucion" },
  {},
);

=head2 auditoriadetalles

Type: has_many

Related object: L<Validador::Esquema::Result::Auditoriadetalle>

=cut

__PACKAGE__->has_many(
  "auditoriadetalles",
  "Validador::Esquema::Result::Auditoriadetalle",
  { "foreign.idauditoria" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-05-06 07:49:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NnXSH4bsLN3fyQfDLiLo7A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
