package EL::API::C;
use strict;
use warnings;
use utf8;
use Encode;
use Carp qw(croak);

sub new {
    my ( $class, $c ) = @_;
    my $self = bless +{
        c      => $c,
        TXN    => [],
    }, $class;
    return $self;
}

1;
