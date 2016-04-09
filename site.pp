############################
# Puppet main site.pp file #
############################

# Backups modified files onto to the puppetmaster
if( $::settings::server )
{
  filebucket { 'main':
    path   => false,
    server => $::settings::server,
  }

  # Set global defaults - including backing up all files to the main filebucket and adds a global path
  File { backup => main, }
}

Exec {
  path => "/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin",
}

# Regex on hostname to determine the role of the node
if empty( hiera( 'role', undef ) )
{
    $role = undef
}
else {
  $role = hiera( 'role' )
}

# Parsing of the hostname to determine the datacenter and the environement of the node
$hostname_infos = split( $::hostname, '-' )
if empty( hiera( 'datacenter', undef ) )
{
  case $hostname_infos[0] {
    'uw2':         { $datacenter = 'uw2' }
    default:       { $datacenter = undef }
  }
}
else {
  $datacenter = hiera( 'datacenter' )
}

######################################################################################

node default {
  hiera_hash('include')['classes'].each |$c| { if $c !~ /^--/ and ! defined( Class[$c] ) { include $c } }
}
