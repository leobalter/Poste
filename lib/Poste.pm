package Poste;
use Mojo::Base 'Mojolicious';

use Poste::Model;
use Poste::Loader;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes Namespace
    $self->routes->namespace('Poste::Controller');

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');
    
    $self->helper(
        model => sub {
            my $dsn = 'dbi:SQLite:' . $self->app->home . '/var/poste.db';
            
            return Poste::Model::instance($dsn);
        }
    );

    # Loading Modules
    my @core_modules = qw{ Root Posts };
    Poste::Loader::load( $self, @core_modules );
}

42;
