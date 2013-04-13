use strict;
use utf8;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'extlib', 'lib', 'perl5');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Plack::Builder;

use EL::API;
use Plack::App::File;
use Plack::Util;
use Plack::Session::Store::DBI;
use Plack::Session::State::Cookie;
use DBI;

my $basedir = File::Spec->rel2abs(dirname(__FILE__));
my $db_config = EL->config->{DBI} || die "Missing configuration for DBI";
{
    my $c = EL->new();
    $c->setup_schema();
}
builder {
    enable 'Plack::Middleware::Static',
        path => qr{^(?:/robots\.txt|/favicon\.ico)$},
        root => File::Spec->catdir(dirname(__FILE__), 'static', 'pc');
    enable 'Plack::Middleware::ReverseProxy';
    enable 'Plack::Middleware::Session',
        store => Plack::Session::Store::DBI->new(
            get_dbh => sub {
                DBI->connect( @$db_config )
                    or die $DBI::errstr;
            }
        ),
        state => Plack::Session::State::Cookie->new(
            httponly => 1,
        );

    mount '/' => EL::API->to_app();
};
