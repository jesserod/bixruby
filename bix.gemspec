Gem::Specification.new do |s|
  s.name        = 'bix'
  s.version     = '0.0.9'
  s.date        = 2013-7-10
  s.summary     = "Lightweight bioinformatics tools for Ruby"
  s.description = "Lightweight bioinformatics tools for Ruby, with a focus on next-gen sequencing" 
  s.authors     = ["Jesse Rodriguez"]
  s.email       = 'jesserod@cs.stanford.edu'
  s.files       = Dir["lib/bix.rb", "lib/bix/*.rb"]
  s.homepage    = 'https://github.com/jesserod/bixruby'
  s.add_dependency('swak')
  s.add_dependency('vcf')
  s.add_dependency('sam')
end
