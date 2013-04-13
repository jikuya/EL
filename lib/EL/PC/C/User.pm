package EL::PC::C::User;
use strict;
use warnings;
use utf8;

sub login {
    my ($class, $c) = @_;
    return $c->render('user/login.tt', {has_error => 0});
}

sub logout {
    my ($class, $c) = @_;
    $c->session->expire();
    $c->redirect('/');
}

sub login_exec {
    my ($class, $c) = @_;
    my $params = $c->req->parameters->as_hashref;
    unless ($params->{user_id} || $params->{password}) {
        return $c->render('user/login.tt', {has_error => 1});
    }

    my $user = $c->db->single('user_data', +{ user_name => $params->{user_name} });
    unless (crypt($params->{password}, 'el') eq $user->{row_data}->{password}) {
        return $c->render('user/login.tt', {has_error => 1});
    }

    $c->session->set('user_data' => $user->{row_data});
    return $c->redirect('/my/');
}

sub create {
    my ($class, $c) = @_;
    my $params = $c->req->parameters->as_hashref;
    unless ($params->{user_id} || $params->{password}) {
        return $c->render('user/create.tt', {has_error => 1});
    }

    my @user = $c->db->search('user_data' => {}, {order_by => 'user_id DESC', limit => 1});
    my $user_id;
    if (scalar(@user)) {
        my $user = shift @user;
        $user_id = $user->{row_data}->{user_id} + 1;
    } else {
        $user_id = 1;
    }

    my $res = $c->db->insert(
        'user_data' => {
            user_id               => $user_id,
            user_name             => $params->{user_name},
            user_name_suffix_type => 1,
            password              => crypt($params->{password} ,'el'),
            created_at            => time,
            status                => 1,
        }
    );
    $c->session->set('user_data' => $res->{row_data});

    return $c->render('user/create.tt', {has_error => 0});
}

1;
