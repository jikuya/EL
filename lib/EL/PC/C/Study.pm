package EL::PC::C::Study;
use strict;
use warnings;
use utf8;

sub today {
    my ($class, $c) = @_;
    my @contents= $c->db->search(
        'user_contents_study_log' => {
            user_id      => $c->user_data->{user_id},
            study_status => 1,
        },
        {order_by => 'contents_id ASC'}
    );
    return $c->render('contents/select.tt', {contents => \@contents});
}

1;
