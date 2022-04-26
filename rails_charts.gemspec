require_relative "lib/rails_charts/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_charts"
  spec.version     = RailsCharts::VERSION
  spec.authors     = [""]
  spec.email       = ["igorkasyanchuk@gmail.com"]
  spec.homepage    = "https://github.com/railsjazz/rails_charts"
  spec.summary     = "One more solution to create charts in Ruby on Rails application"
  spec.description = "One more solution to create charts in Ruby on Rails application"
  spec.license     = "MIT"
  
  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails"

  spec.add_development_dependency "faker"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "groupdate"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "annotate"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"

end
