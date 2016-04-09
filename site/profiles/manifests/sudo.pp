# Required modules/classes :
# saz/sudo

class profiles::sudo (

)  {
    # Deep Merge bug
    $rules = hiera_hash( 'profiles::sudo::rules', {} )

    $defaults = {
        priority => 10,
        content  => undef,
    }

    create_resources( sudo::conf, $rules, $defaults )
}
