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

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'auditoria_id_seq'

Numero de identificacion unica de las auditorias

=head2 idev

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Clave de relacion entre las entidades verificadoras y las auditorias

=head2 idinstitucion

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Clave que relaciona las instituciones con las auditorias

=head2 portal

  data_type: 'varchar'
  is_nullable: 0
  size: 100

Almacena el nombre del portal a auditar

=head2 fechaini

  data_type: 'date'
  is_nullable: 1

Fecha de inicio de la auditoria

=head2 fechafin

  data_type: 'date'
  is_nullable: 1

Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada

=head2 fechacreacion

  data_type: 'date'
  is_nullable: 0

Fecha de creacion de la audioria

=head2 url

  data_type: 'character varying[]'
  is_nullable: 1
  size: 1000

Almacena el listado de las url a auditar en un portal

=head2 estado

  data_type: 'char'
  default_value: 'p'
  is_nullable: 0
  size: 1

Campo que determina el estado de una auditoria, los posibles valores son: p (pendiente), a (abierto), c (cerrado)

=head2 job

  data_type: 'integer'
  is_nullable: 1

=head2 resultado

  data_type: 'boolean'
  is_nullable: 1

Resultado General de la Auditoria, de tipo boolean, TRUE para auditoria sin fallas, FALSE para auditoria fallidas

=head2 fallidas

  data_type: 'integer'
  is_nullable: 1

Numero de disposiciones fallidas

=head2 validas

  data_type: 'integer'
  is_nullable: 1

Numero de disposiciones sin fallas

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "auditoria_id_seq",
  },
  "idev",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "idinstitucion",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "portal",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "fechaini",
  { data_type => "date", is_nullable => 1 },
  "fechafin",
  { data_type => "date", is_nullable => 1 },
  "fechacreacion",
  { data_type => "date", is_nullable => 0 },
  "url",
  { data_type => "character varying[]", is_nullable => 1, size => 1000 },
  "estado",
  { data_type => "char", default_value => "p", is_nullable => 0, size => 1 },
  "job",
  { data_type => "integer", is_nullable => 1 },
  "resultado",
  { data_type => "boolean", is_nullable => 1 },
  "fallidas",
  { data_type => "integer", is_nullable => 1 },
  "validas",
  { data_type => "integer", is_nullable => 1 },
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
  {},
);

=head2 auditoria_results

Type: has_many

Related object: L<Validador::Esquema::Result::AuditoriaResult>

=cut

__PACKAGE__->has_many(
  "auditoria_results",
  "Validador::Esquema::Result::AuditoriaResult",
  { "foreign.id_auditoria" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-23 19:38:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Xx6Z4TW8joEJRZ4gM29xWQ


# You can replace this text with custom content, and it will be preserved on regeneration

sub url_count {
    my $self = shift;
    my $total = scalar @{$self->url};
    return $total;
}

1;
