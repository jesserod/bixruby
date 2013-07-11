require 'csv'

module Bix
  # Reads a tfam file, extracting a list of the individual names
  def self.read_tfam(io_or_fn)
    io = io_or_fn.instance_of?(String) ? File.new(io_or_fn) : io

    inds = []

    for line in io
      line.chomp!
      next if line[0] == '#'
      f = line.split(/\t| /)
      inds << f[1]
    end

    return inds
  end

  # Reads a tped file. Produces a hash of ind_name => [haplotype 1, haplotype 2].
  # ind_list specifies ind_names, if nil, ind names are just 0,1,2...
  # as_array indicates whether haps will be output as strings or arrays
  def self.read_tped(io_or_fn, ind_list=nil, as_array=false)
    io = io_or_fn.instance_of?(String) ? File.new(io_or_fn) : io

    ind_map = nil

    for line in io
      line.chomp!
      next if line[0] == '#'
      f = line.split(/ |\t/)

      if !ind_map
        ind_map = {}
        # Initialize ind_map first
        if ind_list
          for i in 0...ind_list.size
            ind_map[ind_list[i]] = i
          end
        else
          ((f.size-4)/2).times do |ind_idx|
            ind_map[ind_idx] = ind_idx
          end
        end

        # Initialize haps object
        haps = {} # name => [hap1_vec, hap2_vec]
        for name, ind_idx in ind_map
          if as_array
            haps[name] = [[], []]
          else
            haps[name] = ["", ""]
          end
        end
      end


      for name, ind_idx in ind_map
        haps[name][0] << f[4 + 2 * ind_idx + 0]
        haps[name][1] << f[4 + 2 * ind_idx + 1]
      end
    end

    return haps
  end

  # Reads a frq file, producing a list of hashes with the keys
  # :chr, :snp, :a1, :a2, :maf, :nchrobs
  def self.read_frq(io_or_fn)
    io = io_or_fn.instance_of?(String) ? File.new(io_or_fn) : io
    io.gets # header
    res = []
    for line in io
      f = line.chomp.split
      h = {}
      h[:chr] = f[0]
      h[:snp] = f[1]
      h[:a1] = f[2]
      h[:a2] = f[3]
      h[:maf] = f[4].to_f
      h[:nchrobs] = f[5].to_i

      res << h
    end

    return res
  end

end
