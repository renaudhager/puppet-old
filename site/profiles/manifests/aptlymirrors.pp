class profiles::aptlymirrors (){
  $mirrors         = hiera_hash( 'profiles::aptlymirrors', {} )

  validate_hash( $mirrors )

  create_resources( aptly::mirror, $mirrors )
}
