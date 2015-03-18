# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-mit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = [""]
  gem.email         = [""]
  gem.description   = %q{OmniAuth strategy for MIT.}
  gem.summary       = %q{OmniAuth strategy for MIT.}
  gem.homepage      = "https://github.com/FirstToDisclose/omniauth-mit"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-mit"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::MIT::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  # Nothing lower than omniauth-oauth2 1.1.1
  # http://www.rubysec.com/advisories/CVE-2012-6134/
  gem.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
