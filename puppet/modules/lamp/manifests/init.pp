class lamp {

  file { "/opt/config/production/git/lampu/puppet/install_modules.sh":
    mode => 700,
  } -> 
  exec { "install modules":
      command => "install_modules.sh",
      path    => "/usr/local/bin/:/bin/:/opt/config/production/git/lampu/puppet/",
      user    => 'root',
  }

}