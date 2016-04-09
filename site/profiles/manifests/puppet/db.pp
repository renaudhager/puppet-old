class profiles::puppet::db (

) {

  File {
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/puppetlabs/puppetdb/puppetboard_settings.py':
    source  => 'puppet:///modules/profiles/puppet/db/puppetboard_settings.py',
    mode   => '0644',
    require => Package['puppetdb'],
    before  => Docker::Run['puppetboard'],
  }

  file { '/etc/docker/ssl':
    ensure => 'directory',
    require => Class['::docker'],
  } ->

  file { '/etc/docker/ssl/puppetdb.toto.com.crt':
    source => 'puppet:///modules/profiles/puppet/db/ssl/puppetdb.toto.com.crt',
  } ->

  file { '/etc/docker/ssl/puppetdb.toto.com.key':
    source => 'puppet:///modules/profiles/puppet/db/ssl/puppetdb.toto.com.key',
  }

}
