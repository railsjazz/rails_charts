def run_rails_charts_install_template(path)
  system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("../install/#{path}.rb", __dir__)}"
end

namespace :rails_charts do
  desc "Install Rails Charts into the app"
  task :install do
    if Rails.root.join("config/importmap.rb").exist?
      Rake::Task["rails_charts:install:importmap"].invoke
    elsif Rails.root.join("package.json").exist?
      Rake::Task["rails_charts:install:node"].invoke
    elsif defined?(Sprockets)
      Rake::Task["rails_charts:install:sprockets"].invoke
    else
      puts "Unable to install ECharts with current configuration"
    end
  end

  namespace :install do
    desc "Install Rails Charts into the app with asset pipeline"
    task :importmap do
      run_rails_charts_install_template "with_importmap"
    end

    desc "Install Rails Charts into the app with webpacker/esbuild"
    task :node do
      run_rails_charts_install_template "with_node"
    end

    desc "Install Rails Charts into the app with sprockets"
    task :sprockets do
      run_rails_charts_install_template "with_sprockets"
    end
  end
end
