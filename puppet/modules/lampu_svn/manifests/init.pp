class lampu_svn {

  include apache
   
  $vhost_name = $::fqdn
  
  @user { 'www-data': ensure => present }
  
  $repo_dirs = [ "/home/svn", "/home/svn/repo",]
  
  $ca_certs_db = "/opt/config/cacerts"
  
  package { "subversion": ensure => present ,} ->

  package { "libapache2-svn": ensure => present ,} 
  
  group   { "subversion": ensure => "present",}
 

  include maestro::node_vhost_lookup
  $host = $maestro::node_vhost_lookup::vname
 
   file {"/opt/subversion" :
    ensure=>"present",
    content => "https://${host}/svn/repo",
  }
  
  
  User <| title == www-data |> { 
    groups +> "subversion" ,    
    require => Group["subversion"],
  }
  
  file { $repo_dirs:
      ensure => "directory",
      owner  => "www-data",
      group  => "subversion",
      require => User["www-data"],
      mode   => 750,
  }  
  
  file {"/tmp/c.sh":
  ensure=> "present",
  mode => 777,
  content=>"#!/bin/sh
su - www-data -c 'svnadmin create /home/svn/repo'",
	}
	->
	exec {"/tmp/c.sh":  
	  subscribe   => File[$repo_dirs],    
	     refreshonly => true,
  }
  

  
  $cert_file = join([$ca_certs_db ,"/ca2013/certs/${::fqdn}.crt"])
  
  $key_file = join([$ca_certs_db ,"/ca2013/certs/${::fqdn}.key"])
  
  $chain_file = join([$ca_certs_db ,"/ca2013/chain.crt"])
    
  file {['/opt/config',
       $ca_certs_db,
      join([$ca_certs_db ,"/ca2013"]),
      join([$ca_certs_db ,"/ca2013/certs"]),] :    
    ensure => "directory",
  } -> file {$cert_file:
      owner   => 'root',
      group   => 'ssl-cert',
      mode    => '0640',
      content => cacerts_getkey($cert_file),  
      before  => Apache::Vhost[$vhost_name],       
  } -> file { $key_file:
      owner   => 'root',
      group   => 'ssl-cert',
      mode    => '0640',
      content => cacerts_getkey($key_file),  
      before  => Apache::Vhost[$vhost_name],
  } -> file { $chain_file:
      owner   => 'root',
      group   => 'ssl-cert',
      mode    => '0640',
      content => cacerts_getkey($chain_file),  
      before  => Apache::Vhost[$vhost_name],
  }

  a2mod { 'authnz_ldap':
    ensure => present,    
  }
                               
  apache::vhost { $vhost_name:
    port     => 443,
    docroot  => 'MEANINGLESS ARGUMENT',
    priority => '50',
    template => 'lampu_svn/svn.vhost.erb',
    ssl      => true,
  } 
   
  file { '/etc/apache2/mods-enabled/dav_svn.conf':
    ensure => file,  
    content => template("lampu_svn/subversion.conf.erb"),    
    require => Package['libapache2-svn'],
    notify  => Service['apache2'],
  } 

}