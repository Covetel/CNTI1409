package Validador::Esquema::Result::Result;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Result

=cut

__PACKAGE__->table("results");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: SCALAR(0x9eb2588)
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: integer
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1

=head2 pass

  data_type: character varying
  default_value: undef
  is_nullable: 1
  size: 10

=head2 name

  data_type: text
  default_value: undef
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('results_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "pid",
  {
    data_type      => "integer",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
  "pass",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "name",
  { data_type => "text", default_value => undef, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 events

Type: has_many

Related object: L<Validador::Esquema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "Validador::Esquema::Result::Event",
  { "foreign.pid" => "self.id" },
);

=head2 pid

Type: belongs_to

Related object: L<Validador::Esquema::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "pid",
  "Validador::Esquema::Result::Url",
  { id => "pid" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-05-12 17:54:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2x5zYtqkyG8+GH73SSDszw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
