#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
def request(host)
	manager = SNMP::Manager.new(:Host => host)
        response = manager.get(["sysContact.0"])
	response.each_varbind do |vb|
		puts vb.value+"\t"+host
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
