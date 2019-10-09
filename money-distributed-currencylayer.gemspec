# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money/distributed/fetcher/currencylayer/version'

Gem::Specification.new do |spec|
  spec.name          = 'money-distributed-currencylayer'
  spec.version       = Money::Distributed::Fetcher::Currencylayer::VERSION
  spec.authors       = ['DarthSim']
  spec.email         = ['darthsim@gmail.com']

  spec.summary       = 'Currencylayer fetcher for money-distributed gem'
  spec.homepage      = 'https://github.com/DarthSim/money-distributed-currencylayer'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'

  spec.add_dependency 'money-distributed', '>= 0.0.2.2'
  spec.add_dependency 'json'
end
