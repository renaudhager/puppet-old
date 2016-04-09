# Required modules/classes :
# puppetlabs/firewall

class profiles::firewall(
    $enabled = true,
) {
    if $enabled {
        firewallchain { [ 'INPUT:filter:IPv4','OUTPUT:filter:IPv4', 'FORWARD:filter:IPv4', 'PREROUTING:nat:IPv4', 'INPUT:nat:IPv4', 'OUTPUT:nat:IPv4', 'POSTROUTING:nat:IPv4' ]:
          purge  => true,
          ignore => [
             # ignore the fail2ban jump rule
             '-j fail2ban-ssh',
             # ignore Docker
             '-i docker0', '-o docker0', '-j DOCKER', '-s 172.17',
             # ignore any rules with "ignore" (case insensitive) in the comment in the rule
             '--comment "[^"](?i:ignore)[^"]"',
           ],
        }

        if ! defined( Class['profiles::firewall::pre'] ) or ! defined( Class['profiles::firewall::post'] ) {
          class { ['profiles::firewall::pre', 'profiles::firewall::post']: }
        }

        if ! defined( Class['::firewall'] ) {
          include ::firewall
        }
    }
}

class profiles::firewall::pre()  {
    # deep_merge bug, we have to set this here
    $rules = hiera_hash( 'profiles::firewall::pre::rules', undef )
    create_resources( firewall, $rules )
}

class profiles::firewall::post()  {
    # deep_merge bug, we have to set this here
    $rules = hiera_hash( 'profiles::firewall::post::rules', undef )
    create_resources( firewall, $rules )
}
