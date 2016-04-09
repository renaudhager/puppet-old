class profiles::system::limits (
) {
    # DeepMerge bug, we have to set this here
    $limits = hiera_hash( 'profiles::system::limits::rules', {} ) 
    
    $defaults = {
        ensure => present,
    }

    create_resources( limits::limits, $limits, $defaults )
}