package EL::API::C::Contents;
use strict;
use warnings;
use feature 'state';
use utf8;

use parent qw(EL::API::C);

sub user_study_contents_get {
    my ($class, $c, $params) = @_;
    state $v = Data::Validator->new(
        grade_id => 'Num',
    )->with('AllowExtra');
    my ( $args, %extra ) = $v->validate($params);

    my $contents_itr = $c->db->search(
        'contents' => { grade_id => $args->{grade_id} },
        {order_by => 'contents_id ASC'}
    );
    my @contents;
    while ( my $contents = $contents_itr->next ) {
        push @contents, $contents->{row_data};
    }

    return { contents_list => \@contents };
}

sub user_study_contents_item_get {
    my ($class, $c, $params) = @_;
    state $v = Data::Validator->new(
        contents_id => 'Num',
    )->with('AllowExtra');
    my ( $args, %extra ) = $v->validate($params);

    my $contents_item_itr = $c->db->search(
        'contents_item' => { contents_id => $args->{contents_id} },
        {order_by => 'contents_item_id ASC'}
    );
    my @contents_item;
    while ( my $contents_item = $contents_item_itr->next ) {
        push @contents_item, $contents_item->{row_data};
    }

    return { contents_item_list => \@contents_item };
}
`
1;
