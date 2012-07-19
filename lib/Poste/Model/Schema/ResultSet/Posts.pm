package Poste::Model::Schema::ResultSet::Posts;

use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

use Mojo::Util qw( decode );
use DateTime;


sub last_posts {
    my $self = shift;
    my $rows = shift || 10;
    my $page = shift || 1;

    my $rs = $self->search(
        {},
        {
            'join'    => 'authors',
            '+select' => ['authors.full_name'],
            '+as'     => ['author_name'],
            rows      => $rows,
            page      => $page,
            order_by  => { -desc => 'publish_date' }
        }
    );

    my $posts = [];
    foreach my $row ( $rs->all ) {
        my %post = map { decode 'UTF-8', $_; $_ } $row->get_columns;

        $post{publish_date} = date_format( $post{publish_date} );

        push @{$posts}, \%post;
    }

    return $posts;
}


sub post_by_id {
    my $self    = shift;
    my $post_id = shift;

    my $rs = $self->find(
        { post_id => $post_id },
        {
            'join'    => 'authors',
            '+select' => ['authors.full_name'],
            '+as'     => ['author_name'],
        }
    );

    my $post  = {};
    if ( defined $rs ) {
        $post = { map { decode 'UTF-8', $_; $_ } $rs->get_columns };
        $post->{publish_date} = date_format( $post->{publish_date} );
    }
    else {
        $post = {
            post_id      => 0,
            author_id    => 0,
            title        => '',
            content      => '',
            publish_date => 0,
            author_name  => '',
        };
    }

    return $post;
}

sub date_format {
    my $timestamp = shift || 1;
    my $format    = shift || '%b %d, %Y';

    return DateTime->from_epoch( epoch => $timestamp )->strftime($format);
}

return 42;
