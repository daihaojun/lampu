 module Puppet::Parser::Functions
    newfunction(:getenv) do |args|
      return ENV[args[0]]
    end
  end