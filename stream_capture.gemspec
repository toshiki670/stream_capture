# frozen_string_literal: true

require_relative 'lib/stream_capture/version'

Gem::Specification.new do |spec|
  spec.name          = 'stream_capture'
  spec.version       = StreamCapture::VERSION
  spec.authors       = ['Toshiki']
  spec.email         = ['toshiki.dev@protonmail.ch']

  spec.summary       = 'Capture stdout and stderr'
  spec.description   = <<-'DESC'
  This module capture stdout and stderr
  DESC
  spec.homepage      = 'https://github.com/toshiki670/stream_capture'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/toshiki670/stream_capture'
  spec.metadata['changelog_uri'] = 'https://github.com/toshiki670/stream_capture'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'pry-doc', '~> 1.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.3'
end
