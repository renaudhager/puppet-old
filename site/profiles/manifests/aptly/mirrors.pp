class profiles::aptly::mirrors (){
  $mirrors         = hiera_hash( 'profiles::aptly::mirrors::mirrors', {} )

  validate_hash( $mirrors )

  create_resources( aptly::mirror, $mirrors )
}
