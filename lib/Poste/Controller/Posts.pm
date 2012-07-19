package Poste::Controller::Posts;

use Mojo::Base 'Mojolicious::Controller';


sub startup {
    my ( $self, $c ) = @_;

    my $r = $c->routes;

    $r->route('/posts')->to('posts#index');
    $r->route( '/posts/:post_id' )->to('posts#post');
}

sub index {
    my ( $self, $c ) = @_;

    $self->stash( posts => $self->model->resultset('Posts')->last_posts );
}

sub post {
    my ( $self, $c ) = @_;

    my $post_id = $self->param('post_id') || 0;

    my $post = $self->model->resultset('Posts')->post_by_id($post_id);
    
    $self->stash(
        post => $self->model->resultset('Posts')->post_by_id($post_id)
    );
}

42;
