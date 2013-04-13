package EL::PC::C::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    my $user_data = $c->user_data;
    unless ($user_data) {
        return $c->render('user/login.tt', {has_error => 0});
    }
    #my ($entries, $pager) = $c->db->search_with_pager('user_data' => {}, {order_by => 'id DESC', page => $page, rows => 1});
    #$c->render('index.tt', { entries => $entries, pager => $pager });
    $c->render('index.tt');
}

1;
