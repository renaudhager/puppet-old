class profiles::puppet::server (
  $gitlab_api_token    = undef,
  $gitlab_url          = undef,
  $gitlab_project      = undef,
  $config_java_args    = {},
  $config_puppetserver = {},
  $config_bootstrap    = {},
) {
  validate_hash( $config_java_args )
  validate_hash( $config_bootstrap )

  package { ['figlet','make','gcc']:
    ensure => present,
  }

  file { '/etc/puppetlabs/code/hiera.yaml':
    source  => 'puppet:///modules/profiles/puppet/server/hiera.yaml',
    owner   => 'root',
    group   => 'root',
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/auth.conf':
    source => 'puppet:///modules/profiles/puppet/server/auth.conf',
    owner  => 'root',
    group  => 'root',
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/webserver.conf':
    source => 'puppet:///modules/profiles/puppet/server/webserver.conf',
    owner  => 'root',
    group  => 'root',
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf':
    source => 'puppet:///modules/profiles/puppet/server/puppetserver.conf',
    owner  => 'root',
    group  => 'root',
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    source  => 'puppet:///modules/profiles/puppet/server/autosign.conf',
    owner   => 'root',
    group   => 'root',
    notify  => Service['puppetserver'],
  }

  # preserve_knockout functionnality / No valid releases
  file { '/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/vendor/deep_merge/lib/deep_merge/core.rb':
    source  => 'puppet:///modules/profiles/puppet/server/deep_merge_core.rb',
    owner   => 'root',
    group   => 'root',
    notify  => Service['puppetserver'],
  }

  ## camptocamp/puppetserver config

  if ! empty( $config_java_args ) {
    create_resources( puppetserver::config::java_arg, $config_java_args )
  }

  if ! empty( $config_bootstrap ) {
    create_resources( puppetserver::config::bootstrap, $config_bootstrap )
  }


}
