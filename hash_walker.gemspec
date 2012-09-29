Gem::Specification.new do |gem|
    gem.name = %q{hash_walker}
    gem.version = "0.0.1"
    gem.date = %q{2012-09-29}
    gem.summary = %q{A simple gem that allows you to traverse/walk a Hash according to a set of keys (also a hash) and return the primitive values at those keys.}
    gem.files = [
        "lib/hash_walker/core_extensions/hash.rb"
    ]
    gem.require_paths = ["lib","lib/hash_walker", "lib/hash_walker/core_extensions"]
    gem.require_paths = ["lib/hash_walker"]

    gem.name        = %q{hash_walker}
    gem.version = "0.0.1"
    gem.date = %q{2012-09-29}
    gem.authors     = ["Lloyd Meta"]
    gem.email       = ["lloydmeta@gmail.com"]
    gem.homepage    = "http://github.com/lloydmeta/hash_walker"
    gem.description = %q{A simple gem that allows you to traverse/walk a Hash according to a set of keys (also a hash) and return the primitive values at those keys.}
    gem.summary     = gem.description

    gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    gem.files         = `git ls-files`.split("\n")
    gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    gem.require_paths = ["lib"]
end