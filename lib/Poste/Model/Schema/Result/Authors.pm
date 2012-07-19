package Poste::Model::Schema::Result::Authors;

use strict;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('authors');
__PACKAGE__->add_columns(
    author_id   => {
        data_type           => 'integer',
        is_nullable         => 0,
        is_auto_increment   => 1,
        is_numeric          => 1,
        retrieve_on_insert  => 1,
    },
    full_name   => {
        data_type           => 'varchar',
        size                => 80,
        is_nullable         => 0,
        default_value       => '',
        is_numeric          => 0,
        retrieve_on_insert  => 1,
    },
);

__PACKAGE__->set_primary_key('author_id');

__PACKAGE__->has_many(
    'posts' => 'Poste::Model::Schema::Result::Posts',
    { 'foreign.author_id' => 'self.author_id' }
);


42;
