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

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'jobs_id_seq'

=head2 site

  data_type: 'text'
  is_nullable: 1

=head2 callback

  data_type: 'text'
  is_nullable: 1

=head2 data

  data_type: 'text'
  is_nullable: 1

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 proc

  data_type: 'integer'
  is_nullable: 1

=head2 ctime

  data_type: 'timestamp'
  is_nullable: 1

=head2 mtime

  data_type: 'timestamp'
  is_nullable: 1

=head2 pid

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "jobs_id_seq",
  },
  "site",
  { data_type => "text", is_nullable => 1 },
  "callback",
  { data_type => "text", is_nullable => 1 },
  "data",
  { data_type => "text", is_nullable => 1 },
  "state",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "proc",
  { data_type => "integer", is_nullable => 1 },
  "ctime",
  { data_type => "timestamp", is_nullable => 1 },
  "mtime",
  { data_type => "timestamp", is_nullable => 1 },
  "pid",
  { data_type => "integer", is_nullable => 1 },
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
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-20 11:32:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DIb1x33wv6oGoGqIEjyiDw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
