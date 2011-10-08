#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
include SNMP
begin
ip=Array.new
if ARGV.length>0
        t=File.open(ARGV[0],"r")
t.each do |str| 
        manager = SNMP::Manager.new(:Host => str.chomp,:Version=> :SNMPv2c,:Community=>"private")
	varbind = VarBind.new("1.3.6.1.4.1.171.12.1.2.18.1.1.3.3",IpAddress.new("tftpserver"))
	manager.set(varbind)
	varbind = VarBind.new("1.3.6.1.4.1.171.12.1.2.18.1.1.5.3",OctetString.new(str.chomp+".cfg"))
	manager.set(varbind)
	varbind = VarBind.new("1.3.6.1.4.1.171.12.1.2.18.1.1.8.3",SNMP::Integer.new(2))
	manager.set(varbind)
	varbind = VarBind.new("1.3.6.1.4.1.171.12.1.2.18.1.1.12.3",SNMP::Integer.new(3))
	manager.set(varbind)
	manager.close
end
puts ip.uniq
#puts ip
end
rescue StandardError=>bang
puts "Clear sources"+bang
end

