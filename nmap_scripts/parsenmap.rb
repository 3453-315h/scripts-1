#!/usr/bin/ruby
##################
#File = parsenmap
#Author = Royce Davis
#Last edited February 2, 2011
require 'rubygems'
require 'nmap/parser'

unless ARGV.length > 0
  puts "USAGE:\t./parsenmap.rb <nmap xml file>\r\n\n"
  exit!
end

parser = Nmap::Parser.parsefile("#{ARGV[0]}")
parser.hosts("up") do |host|
  [:tcp, :udp].each do |type|
    host.getports(type, "open") do |port|
      string = port.state.to_s
      unless string.include? "filtered" 
        srv = port.service
        puts "#{host.addr}\t#{port.num}\t#{srv.name}\t#{srv.product} #{srv.version}"
     end
    end
  end
end
