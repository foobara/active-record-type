require_relative "version"

Gem::Specification.new do |spec|
  spec.name = "foobara-active-record-type"
  spec.version = Foobara::ActiveRecordType::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Provides a detached entity foobara type for Active Record classes"
  spec.homepage = "https://github.com/foobara/active-record-type"
  spec.license = "MPL-2.0"
  spec.required_ruby_version = Foobara::ActiveRecordType::MINIMUM_RUBY_VERSION

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE*.txt",
    "README.md",
    "CHANGELOG.md"
  ]

  spec.add_dependency "activerecord"
  spec.add_dependency "foobara", ">= 0.1.1", "< 2.0.0"

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
