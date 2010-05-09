package CNTI::ValidatorDB::Result::Results;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("results");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('results_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "pid",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "pass",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("results_pkey", ["id"]);
__PACKAGE__->has_many(
  "events",
  "CNTI::ValidatorDB::Result::Events",
  { "foreign.pid" => "self.id" },
);
__PACKAGE__->belongs_to("pid", "CNTI::ValidatorDB::Result::Urls", { id => "pid" });


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-08 20:12:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EpdUaJtt6fqD6GpyypBi2Q
# These lines were loaded from '/home/opr/CNTI1409/project/pp/CNTI-14-09/CNTI-Validator/lib/CNTI/ValidatorDB/Result/Results.pm' found in @INC.# They are now part of the custom portion of this file# for you to hand-edit.  If you do not either delete# this section or remove that file from @INC, this section# will be repeated redundantly when you re-create this# file again via Loader!
package CNTI::ValidatorDB::Result::Results;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("results");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('results_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "pid",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "pass",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("results_pkey", ["id"]);
__PACKAGE__->has_many(
  "events",
  "CNTI::ValidatorDB::Result::Events",
  { "foreign.pid" => "self.id" },
);
__PACKAGE__->belongs_to("pid", "CNTI::ValidatorDB::Result::Urls", { id => "pid" });


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-05-05 20:33:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g31WmHHEv+P92RnXwGsKeQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
# End of lines loaded from '/home/opr/CNTI1409/project/pp/CNTI-14-09/CNTI-Validator/lib/CNTI/ValidatorDB/Result/Results.pm' 


# You can replace this text with custom content, and it will be preserved on regeneration
1;
