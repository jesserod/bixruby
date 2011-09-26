module Bix
  class Fasta
    attr_accessor :header, :seq
  end

  def self.read_fastas(io)
    fastas = []

    fa = nil

    for line in io
      line.chomp!
      if line[0] == '>'
        fastas << fa if fa != nil

        fa = Bix::Fasta.new
        fa.header = line
        fa.seq = ""
      else
        fa.seq << line
      end

    end

    fastas << fa if fa != nil

    return fastas
  end
end
