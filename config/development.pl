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
        user_study_contents_get => {
            module     => 'EL::API::C::Contents',
            subroutine => 'user_study_contents_get',
        },
        user_study_contents_item_get => {
            module     => 'EL::API::C::Contents',
            subroutine => 'user_study_contents_item_get',
        },
    }
};
