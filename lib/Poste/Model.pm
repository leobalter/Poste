package Poste::Model;

use strict;
use warnings;

use Poste::Model::Schema;

my $__INSTANCE__ = undef;

sub instance {
    unless ( defined $__INSTANCE__ ) {
        my $dsn = shift;

        $__INSTANCE__ =
          bless( { schema => Poste::Model::Schema->connect($dsn) },
            'Poste::Model', );
    }

    return $__INSTANCE__->{schema};
}

42;
