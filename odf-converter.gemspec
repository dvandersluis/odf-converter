# -*- encoding: utf-8 -*-
require File.expand_path('../lib/odf/converter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daniel Vandersluis"]
  gem.email         = ["dvandersluis@selfmgmt.com"]
  gem.description   = %q{Ruby library for converting ODF files through OO.org}
  gem.summary       = %q{Uses a native Ruby-UNO bridge (rubyuno) to connect to OpenOffice.org running as a service and convert ODF documents to a different format.}
  gem.homepage      = "https://www.github.com/dvandersluis/odf-converter"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "odf-converter"
  gem.require_paths = ["lib"]
  gem.version       = ODF::Converter::VERSION
  
  gem.add_dependency "rubyuno"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "pry-editline"
  gem.add_development_dependency "rspec"
end
