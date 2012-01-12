# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
version = File.read(File.expand_path("../../SPREE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "spree_cmd"
  s.version     = version
  s.authors     = ["Chris Mar"]
  s.email       = ["chris@spreecommerce.com"]
  s.homepage    = ""
  s.summary     = %q{Create new Spree stores}
  s.description = %q{command line utility to create new stores or add Spree to existing applications}

  s.rubyforge_project = "spree_cmd"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.bindir        = 'bin'
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
