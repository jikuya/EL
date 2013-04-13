package EL::PC::C::My;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    return $c->render('my/index.tt', {has_error => 0});
}

1;
