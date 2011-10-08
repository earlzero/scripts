#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
ip=Array.new
if ARGV.length>0
        t=File.open(ARGV[0],"r")
t.each do |str| 
	begin 
        	manager = SNMP::Manager.new(:Host => str.chomp,:Version=> :SNMPv2c)
	        response = manager.get(["1.3.6.1.2.1.16.19.2.0"])
	response.each_varbind do |vb|
		puts vb.value+"\t"+str.chomp
	end
	rescue
end
end
end
