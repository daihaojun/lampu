class lampu::jenkins_confg
{
   class {'jenkins_config::jenkinsuser':
   } ->
   class { 'jenkins_config::master':
     
   }
}