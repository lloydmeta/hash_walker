Gem::Specification.new do |gem|
    gem.name        = %q{hash_walker}
    gem.version = "0.0.2"
    gem.date = %q{2012-09-30}
    gem.authors     = ["Lloyd Meta"]
    gem.email       = ["lloydmeta@gmail.com"]
    gem.homepage    = "http://github.com/lloydmeta/hash_walker"
    gem.description = %q{A simple gem that allows you to traverse/walk a Hash according to a set of keys (also a hash), passing in a block to perform actions. This method will yield your block with each value found and the Hash 'path' of the value as arguments}
    gem.summary     = gem.description

    gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    gem.files         = `git ls-files`.split("\n")
    gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    gem.require_paths = ["lib"]
end