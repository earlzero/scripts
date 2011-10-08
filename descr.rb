#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
def request(host)
	manager = SNMP::Manager.new(:Host => host)
        response = manager.get(["1.3.6.1.2.1.16.19.2.0"])
	response.each_varbind do |vb|
	puts host+";"+vb.value.to_s
	end
end
if ARGV.length>0
	f=File.open(ARGV[0],"r")
f.each_line do |str|

	begin
	request(str.chomp)
	rescue
	end
end
end
