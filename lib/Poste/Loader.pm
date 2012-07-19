package Poste::Loader;

use strict;
use warnings;

use Carp qw(croak);

sub load {
    my ( $app, @modules ) = @_;

    foreach my $module ( map { 'Poste::Controller::' . $_ } @modules ) {
        eval "require $module;";
        croak $@ if $@;

        $module->startup($app);
    }
}

42;
