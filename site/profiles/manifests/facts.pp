class profiles::facts (
    $static = {}
)  {

    $static_fact_file_path = $::kernel ? {
      'Linux'   => '/opt/puppetlabs/facter/facts.d/static.yaml',
      'Windows' => 'C:\\ProgramData\\PuppetLabs\\facter\\facts.d\\static.yaml'
    }

    file { $static_fact_file_path:
        owner   => 0,
        group   => 0,
        mode    => '0644',
        content => template( "${module_name}/facts/template.erb" ),
    }
}
