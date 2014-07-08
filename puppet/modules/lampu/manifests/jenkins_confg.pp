class lampu::jenkins_confg
{
  class{'jenkins':
    configure_firewall => false,
  }
}