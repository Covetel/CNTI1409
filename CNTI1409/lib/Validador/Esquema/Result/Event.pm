package Validador::Esquema::Result::Event;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Event

=cut

__PACKAGE__->table("events");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: SCALAR(0x9545cc0)
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: integer
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1

=head2 class

  data_type: text
  default_value: undef
  is_nullable: 1

=head2 message

  data_type: text
  default_value: undef
  is_nullable: 1

=head2 data

  data_type: text
  default_value: undef
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('events_id_seq'::regclass)",
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
  "class",
  { data_type => "text", default_value => undef, is_nullable => 1 },
  "message",
  { data_type => "text", default_value => undef, is_nullable => 1 },
  "data",
  { data_type => "text", default_value => undef, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 pid

Type: belongs_to

Related object: L<Validador::Esquema::Result::Result>

=cut

__PACKAGE__->belongs_to(
  "pid",
  "Validador::Esquema::Result::Result",
  { id => "pid" },
  { join_type => "LEFT" },
);


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-05-18 22:34:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UpXJKCCJ/dL1Vb6+4Y6sng


# You can replace this text with custom content, and it will be preserved on regeneration
1;
