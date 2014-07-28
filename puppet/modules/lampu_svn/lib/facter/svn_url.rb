Facter.add("svn_url") do
 confine :kernel => "Linux"
 setcode do
   #the string to look for and the path should change depending on the system to discover
   if File.exist? "/opt/subversion"
     Facter::Util::Resolution.exec("cat /opt/subversion")
   else
     Facter::Util::Resolution.exec("echo")
   end
 end
end
