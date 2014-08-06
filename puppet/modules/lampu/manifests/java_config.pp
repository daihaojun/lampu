class lampu::java_confg
{
  java_ks { 'puppetca:truststore':
    ensure       => latest,
    certificate  => '/opt/certs/cert01.crt',
    target       => '/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/cacerts',
    password     => 'changeit',
    trustcacerts => true,
  }
  
}
