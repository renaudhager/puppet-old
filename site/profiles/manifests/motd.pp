class profiles::motd (
  $motd_puppet_file  = '/etc/motd.puppet',
  $banner_width      = '110'
)  {

  $ascii = generate('/usr/bin/figlet', '-w', $banner_width, $::hostname )

  case $::operatingsystem {
    'Ubuntu': {
      file { $motd_puppet_file:
        owner => 'root',
        group => 'root',
        mode  => '0644',
        content => template( "${module_name}/motd/template.erb" ),
      }

      file { '/etc/update-motd.d/00-init':
        owner => 'root',
        group => 'root',
        mode  => '0755',
        source => "puppet:///modules/${module_name}/motd/00-init",
        notify => Exec['refresh_motd'],
      }

      $files_to_remove = [ '/etc/update-motd.d/00-header','/etc/update-motd.d/10-help-text','/etc/update-motd.d/50-landscape-sysinfo','/etc/motd','/etc/update-motd.d/98-cloudguest','/etc/update-motd.d/51-cloudguest' ]

      file { $files_to_remove:
        ensure => absent,
      }

      exec { 'refresh_motd':
        command => 'rm -f /run/motd.dynamic',
        creates => '/run/motd.dynamic',
        path    => "/usr/local/bin/:/bin/",
      }
    }
    default: {
      file { '/etc/motd':
        owner => 'root',
        group => 'root',
        mode  => '0644',
        content => template( "${module_name}/motd/template.erb" ),
      }
    }
  }
}
