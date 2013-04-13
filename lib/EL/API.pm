package EL::API;
use strict;
use warnings;
use feature 'state';
use utf8;
use parent qw(EL Amon2::Web);
use File::Spec;
use Encode;
use Carp qw(croak);

use Data::Util qw(is_array_ref is_hash_ref);
use JSON::XS;
use Data::Validator;

# dispatcher
use EL::API::Dispatcher;
sub dispatch {
    return (EL::API::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# load plugins
__PACKAGE__->load_plugins(
);

my $user_data;
sub user_data {
    my $self = shift;
    unless ($user_data) {
        $user_data = $self->session->get('user_data');
    }
    return $user_data;
}

sub format_result_json_rpc {
    my ( $self, $result, $id ) = @_;
    my $json_rpc_ref = +{
        "jsonrpc" => '2.0',
        "result"  => $result,
        "id"      => $id,
    };
    return $json_rpc_ref;
}

sub format_error_json_rpc {
    my ( $self, $error, $id ) = @_;
    my $json_rpc_ref = +{
        "jsonrpc" => '2.0',
        "error"   => $error,
        "id"      => $id,
    };
    return $json_rpc_ref;
}

sub _parse_json_rpc_params {
    my ( $self, $json_rpc_str ) = @_;
    utf8::decode($json_rpc_str);
    my $json_ref = JSON::XS->new->utf8(0)->decode($json_rpc_str);
    if ( is_array_ref($json_ref) ) {
        for my $ref ( @{$json_ref} ) {
            $self->_check_format_json_rpc($ref);
        }
    }
    else {
        $self->_check_format_json_rpc($json_ref);
    }
    return $json_ref;
}

sub _check_format_json_rpc {
    my ( $self, $json_rpc_ref ) = @_;
    state $v = Data::Validator->new(
        id      => 'Str',
        method  => 'Str',
        params  => +{ default => +{} },
        jsonrpc => 'Str',
    );
    $v->validate($json_rpc_ref);
    return;
}

sub _parse_request_json_rpc_str {
    my ( $self, $req ) = @_;
    my $json_rpc_str = '';
    my $input = $req->input;
    $json_rpc_str = do{ local $/; <$input>};
    return $json_rpc_str;
}

sub exception {
    my ( $self, $c, $msg ) = @_;
    croak( +{ show_message => $msg } );
}

1;
