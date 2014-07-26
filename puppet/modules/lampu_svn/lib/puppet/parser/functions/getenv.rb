require 'json'

 module Puppet::Parser::Functions
    newfunction(:getenv, :type => :rvalue) do |args|
      file = File.read('/opt/config/ldap.json')
      data = JSON.parse(file)      
      return data[args[0]]
    end
 end