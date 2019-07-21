# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_booking_system/version'

Gem::Specification.new do |spec|
  spec.name          = 'test_booking_system'
  spec.version       = TestBookingSystem::VERSION
  spec.authors       = ['Viktor Tomilin']
  spec.email         = ['viktortomilin@gmail.com']

  spec.summary       = 'Restaurants booking system'
  spec.homepage      = 'https://github.com/victortomilin/test_booking_system'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/victortomilin/test_booking_system'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activerecord', '~> 5.2'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'database_cleaner', '~> 1.7'
  spec.add_development_dependency 'interactor', '~> 3.0'
  spec.add_development_dependency 'pg', '~> 1.1'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.73'
  spec.add_development_dependency 'simplecov', '~> 0.17'
  spec.add_development_dependency 'standalone_migrations', '~> 5.2'
end
