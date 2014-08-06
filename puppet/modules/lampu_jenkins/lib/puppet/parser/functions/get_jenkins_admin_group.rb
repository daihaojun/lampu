require 'json'

 module Puppet::Parser::Functions
    newfunction(:get_jenkins_admin_group, :type => :rvalue) do |args|
      file = File.read('/opt/config/ldap.json')
      data = JSON.parse(file)      
      return data[args[0]]
    end
 end