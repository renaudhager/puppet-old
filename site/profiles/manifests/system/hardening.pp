class profiles::system::hardening (

) {

  ## vimrc Config:
  case $::osfamily {
    'Debian': {
      $vimrc_path = '/etc/vim/vimrc'
      $bashrc_path = '/etc/bash.bashrc'

      ## Purge os-prober
      package { 'os-prober':
        ensure => 'purged',
      }

      file { '/etc/skel/.bashrc':
        ensure => absent,
      }

      file { '/root/.bashrc':
        ensure => absent,
      }
    }
    'RedHat': {
      $vimrc_path = '/etc/vimrc'
      $bashrc_path = '/etc/bashrc'
    }
  }

  file { $vimrc_path:
    source => "puppet:///modules/profiles/system/hardening/vimrc",
    owner => root,
    group => root,
    mode => '644',
  }

  # bashrc config :
  file { $bashrc_path:
    source => "puppet:///modules/profiles/system/hardening/bashrc",
    owner => root,
    group => root,
    mode => '644',
  }
}
