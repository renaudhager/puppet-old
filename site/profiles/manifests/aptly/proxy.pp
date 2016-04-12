class profiles::aptly::proxy (
  String $key_file = '',
  ){

  file { '/etc/nginx/www':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '755',
  }

  file { '/etc/nginx/www/key':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '755',
    require => File['/etc/nginx/www'],
  }

  file { "/etc/nginx/www/key/${key_file}":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => "puppet:///modules/profiles/aptly/proxy/${key_file}",
    require => File['/etc/nginx/www/key'],
  }
}
