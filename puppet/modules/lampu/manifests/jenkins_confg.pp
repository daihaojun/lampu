class lampu::jenkins_confg
{
   class {'lampu_jenkins::jenkinsuser':
       sudo => false,     
   } ->
   class { 'lampu_jenkins::master':
     
   }
}