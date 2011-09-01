module Bix
  class Fastq
    attr_accessor :header, :seq, :qual, :invalid

    def initialize(header="", seq="", qual="")
      @header = header
      @seq = seq
      @qual = qual
    end

    def from_io(io)
      @header = io.gets
      @seq = io.gets
      io.gets #plus line
      @qual = io.gets

      return false if @header == nil || @seq == nil || @qual == nil
      return true
    end

    def qual_val(i)
      return @qual[i].ord
    end

    def to_lines
      return "#{@header}\n#{@seq}\n+\n#{@qual}"
    end
  end
end
