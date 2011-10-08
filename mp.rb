#!/usr/bin/ruby1.8
require 'rubygems'
require 'snmp'
class TKD
attr :state
attr :errors
attr :address
def request(host)
	@state=Array.new(26)
 	@errors=Array.new(26)	
	manager = SNMP::Manager.new(:Host => host)
        response = manager.get(["sysLocation.0"])
        for i in 1..26
                response = manager.get(["IF-MIB::ifOperStatus."+i.to_s])
                response.each_varbind do |vb|
                resp= manager.get(["SNMPv2-SMI::transmission.7.2.1.3."+i.to_s])
                resp.each_varbind do |vb2|
	        @state[i]=vb.value
		@errors[i]=vb2.value
		end
		end
        end
	@address=host
end
def print
	puts @address
	for i in 1..26
		puts "#{i}\t#{@state[i]}\t#{@errors[i]}";			
	end
end
end

if ARGV.length>0
   res=%x{z "#{ARGV[0]} #{ARGV[1]}"}
   addresses=res.split(/\n/)
   threads=Array.new
   tkds=Array.new(addresses.length)
   addresses.length.times do |i|
  	tkds[i]=TKD.new 
	threads<<Thread.new(addresses[i]) do |addr|
		tkds[i].request(addr)
	end
   end
   addresses.length.times do |i|
	threads[i].join	
   end
   addresses.length.times do |i|
       tkds[i].print 
   end
end
