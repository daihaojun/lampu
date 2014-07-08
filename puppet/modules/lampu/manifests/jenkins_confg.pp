class lampu::jenkins_confg
{
   class {'lampu_jenkins::jenkinsuser':
       sudo => false,     
   } ->
   class { 'lampu_jenkins::master':
     ssl_cert_file =>   "/etc/ssl/certs/%{::fqdn}.pem", 
     ssl_key_file =>             "/etc/ssl/private/%{::fqdn}.key",
     ssl_chain_file =>           '/etc/ssl/certs/intermediate.pem',
     ssl_cert_file_contents =>   '',
		 ssl_key_file_contents =>    '',
		 ssl_chain_file_contents =>  '',
   }  
}