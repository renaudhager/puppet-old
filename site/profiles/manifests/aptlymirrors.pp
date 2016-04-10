class profiles::aptlymirrors (){
  $mirrors         = hiera_hash( 'profiles::aptlymirrors', {} )

  validate_hash( $mirrors )

  $defaults = {
      ensure => present,
  }

  create_resources( aptly::mirror, $mirror, $defaults )
}
