#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
begin
ip=Array.new
if ARGV.length>0
        t=File.open(ARGV[0],"r")
t.each do |str| 
        manager = SNMP::Manager.new(:Host => str.chomp,:Version=> :SNMPv2c)
        manager.walk("1.3.6.1.2.1.17.7.1.2.2.1.2") do |vb| 
        arr=vb.name.to_s.split(/\./)
        ip<<arr[arr.length-7]
end
end
puts ip.uniq
#puts ip
end
rescue StandardError
puts "Clear sources"
end

