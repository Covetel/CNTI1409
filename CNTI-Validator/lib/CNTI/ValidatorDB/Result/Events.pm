package CNTI::ValidatorDB::Result::Events;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("events");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('events_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "result_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "class",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "message",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "data",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("events_pkey", ["id"]);
__PACKAGE__->belongs_to(
  "result_id",
  "CNTI::ValidatorDB::Result::Results",
  { id => "result_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-05 08:23:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r/cQC1mzL74iPijgJYplpA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
