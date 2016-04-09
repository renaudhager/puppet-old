# Required modules/classes :
# jfryman/nginx

class profiles::nginx (

)  {
    # Deep Merge bug
    $vhosts    = hiera_hash( 'profiles::nginx::vhosts', {} )
    $locations = hiera_hash( 'profiles::nginx::locations', {} )
    $upstreams = hiera_hash( 'profiles::nginx::upstreams', {} )

    validate_hash( $vhosts )
    validate_hash( $locations )
    validate_hash( $upstreams )

    $defaults = {
      ensure => present,
    }

    if ! empty( $vhosts ) {
      create_resources( nginx::resource::vhost, $vhosts, $defaults )
    }

    if ! empty( $locations ) {
      create_resources( nginx::resource::location, $locations, $defaults )
    }

    if ! empty( $upstreams ) {
      create_resources( nginx::resource::upstream, $upstreams, $defaults )
    }
}
