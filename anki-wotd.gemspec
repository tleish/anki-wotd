
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "anki/wotd/version"

Gem::Specification.new do |spec|
  spec.name          = "anki-wotd"
  spec.version       = Anki::Wotd::VERSION
  spec.authors       = ["Thomas Leishman"]
  spec.email         = ["tleishman@plansource.com"]

  spec.summary       = %q{Create Anki Word of the Day}
  spec.description   = %q{Create an Anki Word of the Day Card from http://www.wordthink.com/.}
  spec.homepage      = 'https://www.github.com/tleish/anki-wotd'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", "~> 2.0"
  spec.add_runtime_dependency "simple-rss", "~> 1.3"
  spec.add_runtime_dependency "htmlentities", "~> 4.3"
  spec.add_runtime_dependency "xml-simple", "~> 1.1"
  spec.add_runtime_dependency "oxford_dictionary"
  spec.add_runtime_dependency "htmlbeautifier"
  spec.add_runtime_dependency "colorize"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.4"
end
