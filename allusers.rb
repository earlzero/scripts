#!/usr/bin/ruby
require 'rubygems'
require 'snmp'
include SNMP
if ARGV.length>0
        manager = SNMP::Manager.new(:Host => ARGV[0],:Version=> :SNMPv2c,:Community=>"private")
        varbind = VarBind.new("1.3.6.1.4.1.171.12.58.1.1.1.12.#{ARGV[1]}",SNMP::Integer.new(1))
        manager.set(varbind)
        vbs=manager.get(["1.3.6.1.4.1.171.12.58.1.1.1.12.#{ARGV[1]}"])
	puts "Port: \t#{ARGV[1]}"
		t=manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.3.#{ARGV[1]}")
		printf "State: \t"
		if t==1
			puts "Up"
		elsif t==0
			puts "Down"
		else
			puts "Other"
		end
		printf "First pair\t"
		if manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.4.#{ARGV[1]}")==0
			printf "OK"
		else
			printf "Not OK"
		end
		puts "\tlength\t"+manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.8.#{ARGV[1]}").to_s
		printf "Second pair\t"
                if manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.5.#{ARGV[1]}")==0
			printf "OK"
		else
			printf "Not OK"
		end
		puts "\tlength\t"+manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.9.#{ARGV[1]}").to_s
		printf "Third pair\t"
                if manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.6.#{ARGV[1]}")==0
		         printf "OK"
                else
                        printf "Not OK"
                end
                puts "\tlength\t"+manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.10.#{ARGV[1]}").to_s

		printf "Fourth pair\t"
                if manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.7.#{ARGV[1]}")==0
		         printf "OK"
                else
                        printf "Not OK"
                end
                puts "\tlength\t"+manager.get_value("1.3.6.1.4.1.171.12.58.1.1.1.11.#{ARGV[1]}").to_s

	manager.close
end
