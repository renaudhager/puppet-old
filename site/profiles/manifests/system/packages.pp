# Required modules :
# puppetlabs/apt

class profiles::system::packages (

) {
  # DeepMerge bug, we have to set this here
  $packages = hiera_hash( 'profiles::system::packages::packages', {} )

  case $::osfamily {
    'Debian': {
      # To be discussed between L2
      # class { 'apt::unattended_upgrades':
      #   origins => ['${distro_id}:${distro_codename}-security','${distro_id}:${distro_codename}-updates','${distro_id}:${distro_codename}','Puppetlabs ${distro_codename}'],
      # }

      $defaults = {
          ensure  => latest,
          require => Exec['apt_update'],
      }
    }
    default: {
      $defaults = {
        ensure => latest,
      }
    }
  }

  create_resources( package, $packages, $defaults )
}
