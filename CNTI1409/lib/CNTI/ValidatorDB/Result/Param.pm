package CNTI::ValidatorDB::Result::Param;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("params");
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


1;
