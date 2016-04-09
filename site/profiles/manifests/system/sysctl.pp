class profiles::system::sysctl () {
    # DeepMerge bug, we have to set this here
    $rules = hiera_hash( 'profiles::system::sysctl::rules', {} )

    $defaults = {
        ensure => present,
    }

    create_resources( sysctl, $rules, $defaults )
}
