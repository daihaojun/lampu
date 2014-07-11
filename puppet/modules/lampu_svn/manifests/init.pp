class lampu_svn {

  include apache
  
  @user { 'www-data': ensure => present }
  
  $repo_dirs = [ "/home/svn", "/home/svn/repo",]
  
  package { "subversion": ensure => present ,} ->
  package { "libapache2-svn": ensure => present ,} -> 
  group { "subversion": ensure => "present",}  ->
  User <| title == www-data |> { groups +> "subversion" } ->
  file { $repo_dirs:
      ensure => "directory",
      owner  => "www-data",
      group  => "subversion",
      mode   => 750,
  } -> 
  exec { "svnadmin create /home/svn/repo":    
  } -> 
  file { '/etc/apache2/mods-available/dav_svn.conf':
    ensure => file,  
    source => 'puppet:///modules/lampu_svn/subversion.conf',
    notify  => Service['apache2'],
  } ->
  exec {"htpasswd /etc/subversion/passwd admin admin123":}
  -> 
  service { "apache2" : 
    ensure => true,
  }

}