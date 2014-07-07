class php_config::ini {

  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  }

}