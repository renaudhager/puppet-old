class profiles::puppet::agent (

) {

  puppet::setting { 'certname':
    section => 'main',
    value   => $trusted['certname'],
  }

  # Some strange behaviour on some nodes, sometimes the puppet agent hangs during the run.
  # The following adjustments solves it :

  file { '/opt/puppetlabs/puppet/bin/puppet_agent_remediation.rb':
    source => 'puppet:///modules/profiles/puppet/agent/puppet_agent_remediation.rb',
    owner  => 'root',
    group  => 'root',
    mode   => '700',
  }

	cron { 'puppet-agent-remediation':
    ensure  => present,
    user    => 'root',
    command => '/usr/bin/ruby /opt/puppetlabs/puppet/bin/puppet_agent_remediation.rb > /dev/null 2>&1',
    hour  => '*/2',
    require => File['/opt/puppetlabs/puppet/bin/puppet_agent_remediation.rb'],
  }

  ######
}
