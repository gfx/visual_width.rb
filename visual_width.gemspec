# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'visual_width/version'

Gem::Specification.new do |spec|
  spec.name          = "visual_width"
  spec.version       = VisualWidth::VERSION
  spec.authors       = ["Fuji, Goro (gfx)"]
  spec.email         = ["gfuji@cpan.org"]
  spec.description   = %q{Deals with East Asian Width defined in Unicode}
  spec.summary       = %q{Ruby Implementation of East Asian Width}
  spec.homepage      = "https://github.com/gfx/visual_width.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
