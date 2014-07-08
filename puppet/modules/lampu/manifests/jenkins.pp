class lampu::jenkins_confg
{
   class {'lampu_jenkins::jenkinsuser':
   } ->
   class { 'lampu_jenkins::master':
     
   }
}