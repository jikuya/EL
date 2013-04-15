requires 'Amon2'                           => '3.78';
requires 'Amon2::Setup::Flavor::Teng'      => '0.04';
requires 'Text::Xslate'                    => '1.6001';
requires 'Amon2::DBI'                      => '0.30';
requires 'DBD::mysql'                      => '4.022';
requires 'DBD::SQLite'                     => '1.33';
requires 'Teng'                            => '0.18';
requires 'HTML::FillInForm::Lite'          => '1.11';
requires 'JSON'                            => '2.50';
requires 'Module::Find'                    => '0';
requires 'Module::Functions'               => '2';
requires 'Plack::Middleware::ReverseProxy' => '0.09';
requires 'Plack::Middleware::Session'      => '0';
requires 'Plack::Session'                  => '0.14';
requires 'String::CamelCase'               => '0.02';
requires 'Test::WWW::Mechanize::PSGI'      => '0';
requires 'Time::Piece'                     => '1.20';
requires 'Data::Util'                      => '0.62';
requires 'Data::Validator'                 => '1.02';
requires 'UNIVERSAL::require'              => '0.13';

on 'configure' => sub {
   requires 'Module::Build'     => '0.38';
   requires 'Module::CPANfile' => '0.9010';
};

on 'test' => sub {
   requires 'Test::More'     => '0.98';
};
