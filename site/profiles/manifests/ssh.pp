# Required modules/classes :
# saz/ssh

class profiles::ssh (
    $store_configs = false,
)  {
	# Deep Merge bug
    $server_options = hiera_hash( 'profiles::ssh::server_options', {} )
    $client_options = hiera_hash( 'profiles::ssh::client_options', {} )

    class { '::ssh':
        storeconfigs_enabled => $store_configs,
        server_options => $server_options,
        client_options => $client_options,
    }
}
