class lampu::php {
  
  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  } ->
  class { 'php::cli': ensure => '5.3.3' } 
}