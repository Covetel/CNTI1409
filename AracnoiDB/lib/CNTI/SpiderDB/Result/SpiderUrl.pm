package CNTI::SpiderDB::Result::SpiderUrl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CNTI::SpiderDB::Result::SpiderUrl

=cut

__PACKAGE__->table("spider_url");

=head1 ACCESSORS

=head2 job

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 url

  data_type: 'text'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 state

  data_type: 'integer'
  is_nullable: 1

=head2 sum

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=cut

__PACKAGE__->add_columns(
  "job",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "url",
  { data_type => "text", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "state",
  { data_type => "integer", is_nullable => 1 },
  "sum",
  { data_type => "varchar", is_nullable => 1, size => 32 },
);
__PACKAGE__->set_primary_key("job", "url");
__PACKAGE__->add_unique_constraint("job_sum_unique", ["job", "sum"]);

=head1 RELATIONS

=head2 job

Type: belongs_to

Related object: L<CNTI::SpiderDB::Result::SpiderJob>

=cut

__PACKAGE__->belongs_to(
  "job",
  "CNTI::SpiderDB::Result::SpiderJob",
  { id => "job" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-29 19:54:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:C0sNqaWjsapuJZhMoTWe4Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
