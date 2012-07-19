package Poste::Controller::Root;

use Mojo::Base 'Mojolicious::Controller';

sub startup {
    my ( $self, $c ) = @_;

    my $r = $c->routes;

    $r->route('/')->to('posts#index');
    
}

42;
