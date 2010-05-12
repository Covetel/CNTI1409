package Validador::Esquema::Result::Job;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Validador::Esquema::Result::Job

=cut

__PACKAGE__->table("jobs");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: SCALAR(0x9eadd40)
  is_auto_increment: 1
  is_nullable: 0

=head2 site

  data_type: text
  default_value: undef
  is_nullable: 1

=head2 callback

  data_type: text
  default_value: undef
  is_nullable: 1

=head2 data

  data_type: text
  default_value: undef
  is_nullable: 1

=head2 state

  data_type: character varying
  default_value: undef
  is_nullable: 1
  size: 10

=head2 proc

  data_type: integer
  default_value: undef
  is_nullable: 1

=head2 ctime

  data_type: timestamp without time zone
  default_value: undef
  is_nullable: 1

=head2 mtime

  data_type: timestamp without time zone
  default_value: undef
  is_nullable: 1

=head2 pid

  data_type: integer
  default_value: undef
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('jobs_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "site",
  { data_type => "text", default_value => undef, is_nullable => 1 },
  "callback",
  { data_type => "text", default_value => undef, is_nullable => 1 },
  "data",
  { data_type => "text", default_value => undef, is_nullable => 1 },
  "state",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "proc",
  { data_type => "integer", default_value => undef, is_nullable => 1 },
  "ctime",
  {
    data_type     => "timestamp without time zone",
    default_value => undef,
    is_nullable   => 1,
  },
  "mtime",
  {
    data_type     => "timestamp without time zone",
    default_value => undef,
    is_nullable   => 1,
  },
  "pid",
  { data_type => "integer", default_value => undef, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 urls

Type: has_many

Related object: L<Validador::Esquema::Result::Url>

=cut

__PACKAGE__->has_many(
  "urls",
  "Validador::Esquema::Result::Url",
  { "foreign.pid" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05001 @ 2010-05-12 17:54:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:v3uUfJhw7qmRm2XDSyeJgw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
