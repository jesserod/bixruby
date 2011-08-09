#!/usr/bin/env ruby

require "#{File.expand_path(File.dirname(__FILE__) + "/../lib/bix")}"

io = File.new("#{File.dirname(__FILE__)}/../examples/test.fq")

fq = Fastq.new
fq.from_io(io)
puts fq.to_s.inspect
fq.from_io(io)
puts fq.to_s.inspect
fq.from_io(io)
puts fq.to_s.inspect
