class profiles::aptlyproxy (){

  file { '/etc/nginx/www':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '744',
  }

  file { '/etc/nginx/www/27B9DA79.asc':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '744',
    source  => 'puppet:///modules/profiles/aptlyproxy/aptly.pub',
  }
}
