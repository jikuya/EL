package EL::API::Dispatcher;
use strict;
use warnings;
use utf8;

use Compress::Zlib;
use UNIVERSAL::require;

sub dispatch {
    my ($class, $c) = @_;

    my $json_rpc_str = $c->_parse_request_json_rpc_str( $c->req );
    my $json_rpc_ref = $c->_parse_json_rpc_params($json_rpc_str);
    if ( !$json_rpc_ref ) {
        my $res = $c->format_error_json_rpc(
            +{ "code" => -32700, "message" => "Parse error Invalid JSON" } );
        return $c->render_json_rpc($res);
    }

    my $method = $json_rpc_ref->{method};
    my ( $method_res, $call_subroutine ) = call_method(
        $c,
        (
            method => $json_rpc_ref->{method},
            id     => $json_rpc_ref->{id},
            params => $json_rpc_ref->{params}
        )
    );

    return render_json_rpc( $c, $method_res, $method, $call_subroutine );
}

sub call_method {
    my ( $c, %args ) = @_;
    my $method = $args{method};
    my $id     = $args{id};
    my $params = $args{params} || +{};

    my $conf = $c->config->{JSONRPC}->{$method};
    if ( !$conf ) {
        return (
            $c->format_error_json_rpc(
                +{ "code" => -32601, "message" => "Method not found" }
            ),
            ''
        );
    }

    my $module     = $conf->{module};
    my $subroutine = $conf->{subroutine};
    my $call_subroutine = $module.'::'.$subroutine;
    $module->require;
    my $class = $module->new($c);
    my $res = $c->format_result_json_rpc( $class->$subroutine( $c, $params ), $id );
    return ($res, $call_subroutine);
}

sub render_json_rpc {
    my ( $c, $json_rpc_ref, $method, $subroutine) = @_;
    my $output   = JSON::XS->new->utf8->encode($json_rpc_ref);
    my $res      = $c->create_response(200);
    my $encoding = $c->encoding();
    $encoding = lc( $encoding->mime_name ) if ref $encoding;
    $res->header( 'X-Content-Type-Options' => 'nosniff' );    # defense from XSS
    $res->content_type("application/json-rpc; charset=$encoding");

    if ( $c->req->header('Accept-Encoding') =~ /\bgzip\b/i ) {
        $res->header( 'Content-Encoding' => 'gzip' );
        $output = Compress::Zlib::memGzip($output);
    }
    $res->body($output);
    my $content_length = length($output);
    $method = '' unless $method;
    $res->content_length($content_length);

    return $res;
}

1;
