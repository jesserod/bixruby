This gem provides several classes useful for bioinformatics.

Usage
====
    # FASTA/FASTQ
    fas = Bix::read_fastas(io)
    
    fqs = Bix::read_fastqs(io)
    
    fq = Bix::Fastq.new
    fq.from_io(io)
    
    fq = Bix::Fastq.from_io(io)
    

    # BLAST (tab-delim)
    hit = Bix::Blast::Hit.new(line)
    query_hits = Bix::Blast::QueryHits(hits)
    query_hits = Bix::Blast::QueryHits.get_all_query_hits(io)


    # PLINK genotype data
    tfam = Bix::read_tfam(file_or_io)
    tped = Bix::read_tped(file_or_io)
    tped = Bix::read_tped(file_or_io, tfam) # to access by name not idx
    frq  = Bix::read_frq(file_or_io)

Installation
============
To install, just install the `bix` gem:

    sudo gem install bix
