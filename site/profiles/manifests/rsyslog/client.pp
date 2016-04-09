class profiles::rsyslog::client (
    $max_tries_on_failure = 3,
    $rsyslog_package = 'rsyslog',
    $rsyslog_service = 'rsyslog',
)  {
    validate_numeric( $max_tries_on_failure )
    validate_string( $rsyslog_package )
    validate_string( $rsyslog_service )

    # This aims to fix the CAT-261
    # In the future, we should use a complete Puppet module such as saz/rsyslog in order to do that.
    case $osfamily {
        'RedHat': {
            package { $rsyslog_package:
                ensure => present,
            }

            file_line { 'disable_infinite_retry_on_rsyslog_server_failure':
                ensure   => present,
                path     => '/etc/rsyslog.conf',
                line     => "\$ActionResumeRetryCount ${max_tries_on_failure} # Maximum tries on rsyslog server failure",
                match    => '^\$ActionResumeRetryCount .*$',
                notify   => Service[$rsyslog_service],
                require  => Package[$rsyslog_package],
            }

            service { $rsyslog_service:
                ensure  => running,
                enable  => true,
                require => Package[$rsyslog_package],
            }
        }
    }
}