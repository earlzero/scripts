#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
begin
if ARGV.length>0
        t=File.open(ARGV[0],"r")
	t.each do |str| 
		ip=Array.new
	        manager = SNMP::Manager.new(:Host => str.chomp,:Version=> :SNMPv2c)
		printf str.chomp+";"
        	manager.walk("ifPhysAddress") do |vb| 
		vb.value.inspect
#		vb.value.unpack("H2H2H2H2H2H2").join(":") 
		end
		puts
	end
#puts ip
end
rescue StandardError
puts "Clear sources"
end

