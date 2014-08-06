class lampu::java_config
{
  java_ks { 'hp:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/cacerts':
    ensure       => latest,
    certificate  => '/opt/certs/cert01.crt',
    target       => '/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/cacerts',
    password     => 'changeit',
    trustcacerts => true,
  }
  
}
