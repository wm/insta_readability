# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'insta_readability/version'

Gem::Specification.new do |s|
  s.name        = 'insta_readability'
  s.version     = InstaReadability::VERSION
  s.summary     = "InstaReadability"
  s.description = "Upload exported Instapaper csv to Readability.com"
  s.authors     = ["Will Mernagh"]
  s.email       = 'wmernagh@gmail.com'
  s.homepage    = 'https://github.com/wmernagh/insta_readability'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
