define profiles::deleted_user (
  $home = undef,
) {
  user { $name:
      ensure => absent,
  }

  if defined( $home ) {
    file { $home:
        ensure    => absent,
        force     => true,
    }
  }
}
