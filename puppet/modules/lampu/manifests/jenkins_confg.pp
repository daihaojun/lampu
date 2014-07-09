class lampu::jenkins_confg
{
    $ssl_cert_file  = "/etc/ssl/certs/${::fqdn}.pem"
    $ssl_key_file   = "/etc/ssl/private/${::fqdn}.key"
    $ssl_chain_file = '/etc/ssl/certs/intermediate.pem'
    $ca_certs_db    = '/opt/config/cacerts'

    $ssl_cert_file_data      = cacerts_getkey(join([$ca_certs_db ,"/ca2013/certs/${::fqdn}.crt"]))        
    $ssl_chain_file_data     = cacerts_getkey(join([$ca_certs_db ,'/ca2013/chain.crt']))
    $ssl_key_file_data       = cacerts_getkey(join([$ca_certs_db ,"/ca2013/certs/${::fqdn}.key"]))                                      
    
    $jenkins_ssh_public_key  = cacerts_getkey(join([$ca_certs_db , '/ssh_keys/jenkins.pub']))
    $jenkins_ssh_private_key = cacerts_getkey(join([$ca_certs_db ,'/ssh_keys/jenkins']))
    
    ::sysadmin_config::swap { '512':
    } ->
    class { 'lampu_jenkins_config::jenkinsuser':
      sudo => false,
    } ->
    class { 'lampu_jenkins_config::master':
      vhost_name                      => $::fqdn,
      serveradmin                     => "webmaster@${::domain}",
      logo                            => "puppet:///modules/lampu_jenkins_config/openstack.png",
      ssl_cert_file                   => $ssl_cert_file,
      ssl_key_file                    => $ssl_key_file,
      ssl_chain_file                  => $ssl_chain_file,
      ssl_cert_file_contents          => $ssl_cert_file_data,
      ssl_key_file_contents           => $ssl_key_file_data,
      ssl_chain_file_contents         => $ssl_chain_file_data,
      jenkins_ssh_private_key         => $jenkins_ssh_private_key,
      jenkins_ssh_public_key          => $jenkins_ssh_public_key,
    }
    
    lampu_jenkins_config::plugin { 'ansicolor':
      version => '0.3.1',
    }
    lampu_jenkins_config::plugin { 'bazaar':
      version => '1.20',
    }
    lampu_jenkins_config::plugin { 'build-timeout':
      version => '1.10',
    }
    lampu_jenkins_config::plugin { 'copyartifact':
      version => '1.22',
    }
    lampu_jenkins_config::plugin { 'dashboard-view':
      version => '2.3',
    }
    lampu_jenkins_config::plugin { 'envinject':
      version => '1.70',
    }
    lampu_jenkins_config::plugin { 'gearman-plugin':
      version => '0.0.3',
    }
    lampu_jenkins_config::plugin { 'git':
      version => '1.1.23',
    }
    lampu_jenkins_config::plugin { 'github-api':
      version => '1.33',
    }
    lampu_jenkins_config::plugin { 'github':
      version => '1.4',
    }
    lampu_jenkins_config::plugin { 'greenballs':
      version => '1.12',
    }
    lampu_jenkins_config::plugin { 'htmlpublisher':
      version => '1.0',
    }
    lampu_jenkins_config::plugin { 'extended-read-permission':
      version => '1.0',
    }
    lampu_jenkins_config::plugin { 'postbuild-task':
      version => '1.8',
    }
 
    lampu_jenkins_config::plugin { 'jclouds-jenkins':
      version => '2.3.1',
    }
 
    lampu_jenkins_config::plugin { 'violations':
      version => '0.7.11',
    }
    lampu_jenkins_config::plugin { 'jobConfigHistory':
      version => '1.13',
    }
    lampu_jenkins_config::plugin { 'monitoring':
      version => '1.40.0',
    }
    lampu_jenkins_config::plugin { 'nodelabelparameter':
      version => '1.2.1',
    }
    lampu_jenkins_config::plugin { 'notification':
      version => '1.4',
    }
    lampu_jenkins_config::plugin { 'openid':
      version => '1.5',
    }
    lampu_jenkins_config::plugin { 'parameterized-trigger':
      version => '2.15',
    }
    lampu_jenkins_config::plugin { 'publish-over-ftp':
      version => '1.7',
    }
    lampu_jenkins_config::plugin { 'rebuild':
      version => '1.14',
    }
    lampu_jenkins_config::plugin { 'simple-theme-plugin':
      version => '0.2',
    }
    lampu_jenkins_config::plugin { 'timestamper':
      version => '1.3.1',
    }
    lampu_jenkins_config::plugin { 'token-macro':
      version => '1.5.1',
    }
    lampu_jenkins_config::plugin { 'url-change-trigger':
      version => '1.2',
    }
    lampu_jenkins_config::plugin { 'urltrigger':
      version => '0.24',
    }
}