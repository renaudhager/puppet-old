class profiles::aptlyproxy (){

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

  file { '/etc/nginx/www/key/27B9DA79.asc':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => 'puppet:///modules/profiles/aptlyproxy/aptly.pub',
    require => File['/etc/nginx/www/key'],
  }
}
