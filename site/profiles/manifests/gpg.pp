class profiles::gpg (
  Hash $gpg_key = {},
  ){

  create_resources( profiles::gpg::gpg_key , $gpg_key)

}

################################################################################
# gpg_cmd: gpg cmd use to import key.
# gpg_cmd_list: gpg cmd use to to check if the key is present.
# gpg_key_id: key id (8 last digit of the finger print).
# gpg_key_value : string containing the value of the key.
# gpg_store : gpg keyring.
# owner : gpg_store unix owner.
################################################################################

define profiles::gpg::gpg_key (
  String $ensure  = 'present',
  String $gpg_store = '',
  String $gpg_key_value = '',
  String $gpg_key_id = '',
  String $gpg_cmd = '/usr/bin/gpg --no-default-keyring --import --keyring',
  String $gpg_cmd_list = '/usr/bin/gpg --no-default-keyring --list-keys  --keyring',
  String $owner = '',
  ) {

    exec { "import-gpg":
        path    => '/bin:/usr/bin',
        command => "echo '${gpg_key_value}' | ${gpg_cmd} ${gpg_store}",
        unless  => "echo '${gpg_key_id}' | xargs -n1 ${gpg_cmd_list} ${gpg_store}",
        user    => $owner,
      }

}
