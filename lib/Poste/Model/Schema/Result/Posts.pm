package Poste::Model::Schema::Result::Posts;

use strict;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('posts');
__PACKAGE__->add_columns(
    post_id         => {
        data_type           => 'integer',
        is_nullable         => 0,
        is_auto_increment   => 1,
        is_numeric          => 1,
        retrieve_on_insert  => 1,
    },
    author_id       => {
        data_type           => 'integer',
        is_nullable         => 0,
        is_numeric          => 1,
        is_foreign_key      => 1,
    },
    title           => {
        data_type           => 'text',
        is_nullable         => 0,
        is_numeric          => 0,
    },
    content         => {
        data_type           => 'text',
        is_nullable         => 0,
        is_numeric          => 0,
    },
    publish_date    => {
        data_type           => 'integer',
        is_nullable         => 0,
        is_numeric          => 1,
    },
);

__PACKAGE__->set_primary_key('post_id');

__PACKAGE__->belongs_to(
    'authors' => 'Poste::Model::Schema::Result::Authors',
    'author_id'
);


42;
