# Would need some refacto for Puppet 4

class profiles::puppet::ca (
  $ensure = present,
) {

	file { '/usr/local/bin/puppet-ca-webhook':
    ensure => $ensure,
    source => 'puppet:///modules/profiles/puppet/ca/puppet-ca-webhook.rb',
    owner  => 'root',
    group  => 'root',
    mode   => '700',
    notify => Service['puppet-ca-webhook'],
  }

  file { '/etc/init/puppet-ca-webhook.conf':
    ensure => $ensure,
    source => 'puppet:///modules/profiles/puppet/ca/puppet-ca-webhook.init',
    owner  => 'root',
    group  => 'root',
    notify => Service['puppet-ca-webhook'],
  }

  service { 'puppet-ca-webhook':
    ensure  => running,
    enable  => true,
    require => [File['/usr/local/bin/puppet-ca-webhook'],File['/etc/init/puppet-ca-webhook.conf']],
  }
}
