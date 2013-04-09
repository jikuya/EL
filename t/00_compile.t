use strict;
use warnings;
use Test::More;

use_ok $_ for qw(
    EL
    EL::PC
    EL::PC::Dispatcher
    EL::PC::C::Root
    EL::PC::C::Account
    EL::PC::ViewFunctions
    EL::PC::View
    EL::Admin
    EL::Admin::Dispatcher
    EL::Admin::C::Root
    EL::Admin::ViewFunctions
    EL::Admin::View
);

done_testing;
