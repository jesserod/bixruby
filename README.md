Overview
============

This gem provides several classes useful for bioinformatics.

To install, just install the `bix` gem:

    sudo gem install bix


Overview
====
  fas = Bix::read_fastas(io)

  fqs = Bix::read_fastqs(io)

  fq = Bix::Fastq.new
  fq.from_io(io)

  fq = Bix::Fastq.from_io(io)

  # Tab-delim blast interface
  hit = Bix::Blast::Hit.new(line)
  query_hits = Bix::Blast::QueryHits(hits)
  query_hits = Bix::Blast::QueryHits.get_all_query_hits(io)
