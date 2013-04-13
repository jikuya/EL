package EL::API::C::Root;
use strict;
use warnings;
use utf8;

use parent qw(EL::API::C);

sub test {
    my ($class, $c) = @_;
    return { test => 'test' };
}

1;
