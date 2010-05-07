package CNTI::ValidatorDB::Result::Jobs;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("jobs");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('jobs_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "site",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "callback",
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
  "state",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "ctime",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "mtime",
  {
    data_type => "timestamp without time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "parent",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("jobs_pkey", ["id"]);
__PACKAGE__->has_many(
  "urls",
  "CNTI::ValidatorDB::Result::Urls",
  { "foreign.parent" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-05 19:51:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ir3cnigO4rO2vtEWG+7xpw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
