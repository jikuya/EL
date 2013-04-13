package EL::PC::C::Contents;
use strict;
use warnings;
use utf8;

sub select {
    my ($class, $c) = @_;
    my @contents= $c->db->search('contents' => {}, {order_by => 'contents_id ASC'});
    return $c->render('contents/select.tt', {contents => \@contents});
}

sub select_exec {
    my ($class, $c) = @_;
    my $params = $c->req->parameters->as_hashref;
    unless ($params->{contents_id}) {
        my @contents= $c->db->search('contents' => {}, {order_by => 'contents_id ASC'});
        return $c->render('contents/select.tt', {contents => \@contents});
    }

use Data::Dumper;
die Dumper $c->user_data;

    $c->db->insert(
        'user_contents_study_log' => {
            user_id          => $c->user_data->{user_id},
            contents_id      => $params->{contents_id},
            study_start_time => time,
            study_end_time   => 0,
            study_status     => 1,
        }
    );
    return $c->redirect('/my/');
}

1;
