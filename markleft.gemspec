# frozen_string_literal: true

require_relative "lib/markleft/version"

Gem::Specification.new do |spec|
  spec.name = "Markleft"
  spec.version = Markleft::VERSION
  spec.authors = ["greeenboi"]
  spec.email = ["suvan.gowrishanker.204@gmail.com"]

  spec.summary = "TUI built on ruby to compile gh-flavor and more markdown to html for the web to render"
  spec.description = "MarkLeft is a powerful and flexible tool designed to extend the capabilities of traditional Markdown-to-HTML compilers. It introduces additional syntax and features to enhance the expressiveness and functionality of Markdown documents."
  spec.homepage = "https://github.com/greeenboi/markdown-superset-compiler/tree/master"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["github_repo"] = "ssh://github.com/greeenboi/markdown-superset-compiler"
  spec.metadata["source_code_uri"] = "https://github.com/greeenboi/markdown-superset-compiler/tree/master"
  spec.metadata["changelog_uri"] = "https://github.com/greeenboi/markdown-superset-compiler/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
