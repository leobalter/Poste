package Poste::Controller::Posts;

use Mojo::Base 'Mojolicious::Controller';

use Paginator::Lite;

sub startup {
    my ( $self, $c ) = @_;

    my $r = $c->routes;

    $r->route('/posts/')->to('posts#index');
    $r->route('/posts/page/:curr')->to('posts#index');
    $r->route( '/posts/:post_id' )->to('posts#post');
}

sub index {
    my ( $self, $c ) = @_;
    
    my $curr = $self->param('curr') || 1;
    $curr = $curr =~ /^\d+$/ && $curr > 0 ? $curr : 1;
    
    my $page_size   = 3;
    my $frame_size  = 3;
    
    my $rs = $self->model->resultset('Posts');
    
    my $paginator = Paginator::Lite->new({
        curr        => $curr,
        items       => $rs->count,
        frame_size  => $frame_size,
        page_size   => $page_size,
        base_url    => '/posts/page/',
    });

    $self->stash(
        posts       => $rs->last_posts( $page_size, $curr ),
        paginator   => $paginator,
    );
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
