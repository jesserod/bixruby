#!/usr/bin/env ruby

require "#{File.expand_path(File.dirname(__FILE__) + "/../lib/bix")}"

def get_io
  return File.new("#{File.dirname(__FILE__)}/../examples/test.gtf")
end

require 'pp'

pp Bix::Gtf.get_all(get_io)
puts
puts "-----------"
puts
pp Bix::Gtf.get_all(get_io, /exon/i)
puts
puts "-----------"
puts
pp Bix::Gtf.get_all_by_prop(get_io, "gene_name", /exon/i)
puts
puts "-----------"
puts
