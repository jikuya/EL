use File::Spec;
use File::Basename qw(dirname);
+{
    'DBI' => [
        "dbi:mysql:database=el",
        'root',
        '',
        {mysql_enable_utf8 => 1}
    ],
    'JSONRPC' => {
        test => {
            module     => 'EL::API::C::Root',
            subroutine => 'test',
        },
    }
};
