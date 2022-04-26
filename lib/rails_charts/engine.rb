module RailsCharts
  class Engine < ::Rails::Engine

    initializer "rails_charts.importmap", before: "importmap" do |app|
      if defined?(Importmap)
        app.config.assets.paths << File.expand_path('../..', __dir__) + "/vendor/assets"
        app.config.assets.precompile << ".js"

        app.config.assets.precompile += [
          'vendor/assets/**/*', 
          'vendor/assets/rails_charts/**/*'
        ]        

        app.config.importmap.cache_sweepers << Engine.root.join("vendor/assets/rails_charts")
        app.config.importmap.cache_sweepers << Engine.root.join("vendor/assets")
      end
    end
    
    initializer 'rails_charts.assets_precompile' do |app|
      app.config.assets.paths << File.expand_path('../..', __dir__) + "/vendor/assets"
      app.config.assets.precompile += [
        'vendor/assets/**/*', 
      ]
    end

    initializer 'rails_charts.helpers' do
      ActiveSupport.on_load :action_view do
        include RailsCharts::Helpers
      end      
    end

  end
end
