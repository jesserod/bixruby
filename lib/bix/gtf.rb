require 'csv'

module Bix
  class Gtf
    attr_accessor :chr, :prog, :feature, :start, :stop, :score, :strand, :frame, :props

    def from_line(line)
      f = line.chomp.split("\t", -1)
      @chr = f[0]
      @prog = f[1]
      @feature = f[2]
      @start = f[3].to_i
      raise if @start < 1
      @stop = f[4].to_i
      raise if @stop < 1
      @score = f[5].to_f
      @strand = f[6]
      raise if @strand.size > 1
      @frame = f[7].to_i

      group = f[8]

      group.gsub!(/; /, " ") # Remove semicolons
      group.gsub!(/;$/, "") # Remove semicolons
      f = CSV::parse_line(group, :col_sep => ' ')
      raise "Unexpected number of fields in group: '#{f[7]}'" unless f.size % 2 == 0

      @props = {}
      while f.size > 0
        key = f.shift
        value = f.shift

        @props[key] = value
      end
    end

    # E.g. to get all exons
    def self.get_all(io, feature_regex=//)
      gtfs = []
      for line in io
        g = Gtf.new
        g.from_line(line)
        if g.feature =~ feature_regex
          gtfs << g
        end
      end
      return gtfs
    end

    def self.get_all_by_prop(io, prop_key, feature_regex=//)
      gtfs = get_all(io, feature_regex)
      gtfs_by_key = {}
      for g in gtfs
        gtfs_by_key[g.props[prop_key]] ||= []
        gtfs_by_key[g.props[prop_key]] << g
      end
      return gtfs_by_key
    end

    def to_s
      propstr = ""
      i = 0
      for key, value in @props
        if i > 0
          propstr << " "
        end
        propstr << "#{key} \"#{value}\";"
        i += 1
      end
      return [@chr, @prog, @feature, @start, @stop, @score, @strand, @frame, propstr].join("\t")
    end
  end
end
