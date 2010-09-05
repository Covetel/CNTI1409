package CNTI::SpiderDB::Result::SpiderJob;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CNTI::SpiderDB::Result::SpiderJob

=cut

__PACKAGE__->table("spider_job");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 num

  data_type: 'integer'
  is_nullable: 1

=head2 dir

  data_type: 'integer'
  is_nullable: 1

=head2 depth

  data_type: 'integer'
  is_nullable: 1

=head2 base

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 state

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "num",
  { data_type => "integer", is_nullable => 1 },
  "dir",
  { data_type => "integer", is_nullable => 1 },
  "depth",
  { data_type => "integer", is_nullable => 1 },
  "base",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "state",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 spider_urls

Type: has_many

Related object: L<CNTI::SpiderDB::Result::SpiderUrl>

=cut

__PACKAGE__->has_many(
  "spider_urls",
  "CNTI::SpiderDB::Result::SpiderUrl",
  { "foreign.job" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-29 19:43:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ASKManzF7iXjYfAKbujoKQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
