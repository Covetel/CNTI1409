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
  "proc",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
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
  "pid",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("jobs_pkey", ["id"]);
__PACKAGE__->has_many(
  "urls",
  "CNTI::ValidatorDB::Result::Urls",
  { "foreign.pid" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-08 20:12:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2bGD7AtYZl9r3P/tOavSRA
# These lines were loaded from '/home/opr/CNTI1409/project/pp/CNTI-14-09/CNTI-Validator/lib/CNTI/ValidatorDB/Result/Jobs.pm' found in @INC.# They are now part of the custom portion of this file# for you to hand-edit.  If you do not either delete# this section or remove that file from @INC, this section# will be repeated redundantly when you re-create this# file again via Loader!
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
  "pid",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("jobs_pkey", ["id"]);
__PACKAGE__->has_many(
  "urls",
  "CNTI::ValidatorDB::Result::Urls",
  { "foreign.pid" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-05 20:33:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EdJYN9AAUgLzU6lDrSpKmA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
# End of lines loaded from '/home/opr/CNTI1409/project/pp/CNTI-14-09/CNTI-Validator/lib/CNTI/ValidatorDB/Result/Jobs.pm' 


# You can replace this text with custom content, and it will be preserved on regeneration
1;
