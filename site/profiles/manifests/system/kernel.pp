class profiles::system::kernel (
) {
    # DeepMerge bug, we have to set this here
    $parameters = hiera_hash( 'profiles::system::kernel::parameters', {} ) 
    
    $defaults = {
        ensure => present,
        provider => 'grub2',
    }

    create_resources( kernel_parameter, $parameters, $defaults )
}