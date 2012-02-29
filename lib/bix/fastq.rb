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
      io.gets # Throw away + line
      @qual = io.gets

      return false if @header == nil || @seq == nil || @qual == nil

      @header.chomp!
      @seq.chomp!
      @qual.chomp!

      return true
    end

    def self.from_io(io)
      fq = Fastq.new
      if fq.from_io(io)
        return fq
      else
        return nil
      end
    end

    def qual_val(i)
      return @qual[i].ord
    end

    def to_lines
      return "#{@header}\n#{@seq}\n+\n#{@qual}"
    end
  end

  def self.get_all_fastqs(io)
    fqs = []
    while(fq = Fastq.from_io(io))
      fqs << fq
    end
    return fqs
  end
end
