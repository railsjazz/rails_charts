module RailsCharts
  class Railtie < ::Rails::Railtie
    # for importmap
    initializer "rails_charts.importmap" do |app|
      if defined?(Importmap)
        app.config.assets.precompile << ".js"
      end
    end
    
    initializer 'rails_charts.assets_precompile' do |app|
      app.config.assets.paths << File.expand_path('../..', __dir__) + "/vendor/assets"

      # app.config.assets.precompile += [
      #   'vendor/assets/rails_charts/*', 
      #   'vendor/assets/rails_charts/**/*'
      # ]
    end

    initializer 'rails_charts.helpers' do
      ActiveSupport.on_load :action_view do
        include RailsCharts::Helpers
      end      
    end

    initializer :run_prepare_callbacks do |app|
      puts 1111
      app.reloader.prepare!
    end

    config.to_prepare do
      puts 22222
    end
  end
end
