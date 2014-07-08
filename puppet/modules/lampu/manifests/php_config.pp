class lampu::php_config {
  
  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  } ->
  class { 'php::cli': } 
}