#!/usr/bin/ruby
require 'rubygems'
require 'snmp'
require 'mathn'
if ARGV.length>0
	dupes=Hash.new
        iptoid=Hash.new
	ridtoip=Hash.new
	f=File.open(ARGV[0],"r")
	out=File.new("result.gml","w")
	out.puts "Creator \"Selfmade\"\nVersion \"0.0\"\ngraph\n[\ndirected 1"
	ip=f.readlines
	i=0
        ip.each do |str|
                manager=SNMP::Manager.new(:Host=>str.chomp,:Version=> :SNMPv2c)
		iptoid[manager.get_value("1.3.6.1.2.1.14.1.1.0")]=i
		ridtoip[i]=str.chomp
		i+=1
                manager.walk("1.3.6.1.2.1.14.10.1.1") do |vb|
                        manager2=SNMP::Manager.new(:Host=>vb.value.to_s,:Version=> :SNMPv2c)
                        begin
                        printf ";%s",manager2.get_value("1.3.6.1.2.1.14.1.1.0").to_s
                        rescue => bang
                                puts "Fuck"+vb.value+":"+bang
                        end
                end
		puts
        end
	I=Array.new(i)
	I.map! {Array.new(i)}
	iptoid.each do |val1,val2|
                manager=SNMP::Manager.new(:Host=>ridtoip[val2].to_s,:Version=> :SNMPv2c)
		out.puts "node ["
		out.puts "id "+val2.to_s
		out.puts "label \""+manager.get_value("1.3.6.1.2.1.14.1.1.0").to_s+"\"\n]"
	end
        ip.each do |str|
                manager=SNMP::Manager.new(:Host=>str.chomp,:Version=> :SNMPv2c)
                manager.walk("1.3.6.1.2.1.14.10.1.1") do |vb|
                        manager2=SNMP::Manager.new(:Host=>vb.value.to_s,:Version=> :SNMPv2c)
                        begin
                        printf ";%s",manager2.get_value("1.3.6.1.2.1.14.1.1.0").to_s
			i=iptoid[manager.get_value("1.3.6.1.2.1.14.1.1.0")].to_i
			j=iptoid[manager2.get_value("1.3.6.1.2.1.14.1.1.0")].to_i
			if(iptoid[manager.get_value("1.3.6.1.2.1.14.1.1.0")].to_s.length>0 && iptoid[manager2.get_value("1.3.6.1.2.1.14.1.1.0")].to_s.length>0)
			I[i][j]=1
			I[j][i]=0		
#			out.puts "edge\n[\nsource "+iptoid[manager.get_value("1.3.6.1.2.1.14.1.1.0")].to_s+"\ntarget "+iptoid[manager2.get_value("1.3.6.1.2.1.14.1.1.0")].to_s+"\n]"
			end
#			out.puts iptoid[manager.get_value("1.3.6.1.2.1.14.1.1.0")].to_s.length
#			out.puts iptoid[manager2.get_value("1.3.6.1.2.1.14.1.1.0")].to_s.length
                        rescue => bang
                                puts "Fuck"+vb.value+":"+bang
                        end
                end
		puts
	end
	for i in 0..I.size
		for j in i+1..I.size
			I[i][j]=0
		end
	end
	for i in 0..I.size-1
		for j in 0..I.size-1
			if(I[i][j]==1)
			out.puts "edge\n[\nsource "+i.to_s+"\ntarget "+j.to_s+"\n]"
			end
	end
	end
	out.puts "]"
	out.close
	puts ridtoip
end
