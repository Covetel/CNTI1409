package CNTI::ValidatorDB::Result::Urls;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("urls");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('urls_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "job_id",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "path",
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
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("urls_pkey", ["id"]);
__PACKAGE__->has_many(
  "results",
  "CNTI::ValidatorDB::Result::Results",
  { "foreign.url_id" => "self.id" },
);
__PACKAGE__->belongs_to(
  "job_id",
  "CNTI::ValidatorDB::Result::Jobs",
  { id => "job_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-05 08:09:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/lhlHZuSf6+uZM70AkPKKw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
