#!/usr/bin/env ruby

require 'swak'

module Bix
  module Blast
    class Hit
      Attribs =  [:query, :subject, :perc_id, :align_len, :mismatches, 
                    :gap_opens, :query_start, :query_end, :subject_start,
                    :subject_end, :e_value, :bit_score]

      attr_accessor *Attribs

      def initialize(line=nil)
        if line != nil && line[0] != '#'
          f = line.chomp.split("\t", -1)

          raise "Illegal number of fields for blast hit" unless f.size == 12

          @query = f[0]
          @subject = f[1]
          @perc_id = f[2].to_f_strict
          @align_len = f[3].to_i_strict
          @mismatches = f[4].to_i_strict
          @gap_opens = f[5].to_i_strict
          @query_start = f[6].to_i_strict
          @query_end = f[7].to_i_strict
          @subject_start = f[8].to_i_strict
          @subject_end = f[9].to_i_strict
          @e_value = f[10].to_f_strict
          @bit_score = f[11].to_f_strict
        end
      end

      def to_arr
        return Attribs.map{|a| self.send(a)}
      end
    end

    class QueryHits
      attr_accessor :query, :hits, :best_hit, :pref_min_aln_len

      # Suppose we want the best_hit to point to the best e-value of all hits over a certain aln len
      # If there are no hits over that length, then we want the best e-value
      def initialize(hits, pref_min_aln_len=0)
        @pref_min_aln_len = pref_min_aln_len
        @hits = hits

        raise "QueryHits error: must have > 0 hits"  unless hits.size > 0

        @query = hits.first.query
        @best_hit = hits.first

        for h in hits
          raise "QueryHits error: not all hits have same query!" if h.query != query

          if @best_hit.align_len < pref_min_aln_len && h.align_len >= pref_min_aln_len
            @best_hit = h
          elsif h.e_value < @best_hit.e_value
            @best_hit = h
          end
        end
      end
    end

    def self.get_all_query_hits(io, pref_min_aln_len=0)
      hits_by_query = {}

      # Read all blast hits into memory, group them by query name
      for line in io
        next if line[0] == '#'
        h = Hit.new(line)
        hits_by_query[h.query] ||= []
        hits_by_query[h.query] << h
      end

      # Build vector of QueryHits objects
      query_hits = []

      for query, hits in hits_by_query
        query_hits << QueryHits.new(hits, pref_min_aln_len)
      end

      return query_hits
    end
  end
end
