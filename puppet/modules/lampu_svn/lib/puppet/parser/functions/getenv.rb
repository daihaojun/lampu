 module Puppet::Parser::Functions
    newfunction(:getenv, :type => :rvalue) do |args|
      return ENV[args[0]]
    end
  end