package Validador::Esquema::Result::Param;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Param - Parametros de las disposiciones

=cut

__PACKAGE__->table("params");

=head1 ACCESSORS

=head2 id

  data_type: bigint
  default_value: SCALAR(0x9dda5a8)
  is_auto_increment: 1
  is_nullable: 0

=head2 disposicion

  data_type: character varying
  default_value: undef
  is_nullable: 0
  size: undef

=head2 parametro

  data_type: character varying
  default_value: undef
  is_nullable: 0
  size: undef

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    default_value     => \"nextval('params_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "disposicion",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "parametro",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-08-23 07:11:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h4CipI94YKpqM2Sc2dsKlQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
