module RailsCharts
  class Engine < ::Rails::Engine

    initializer "rails_charts.importmap", before: "importmap" do |app|
      if defined?(Importmap)
        app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
      end
    end

    # If you don't want to precompile Echarts's assets (eg. because you're using webpack),
    # you can do this in an intiailzer:
    #
    # config.after_initialize do
    #   config.assets.precompile -= RailsCharts::Engine::PRECOMPILE_ASSETS
    # end

    PRECOMPILE_ASSETS = Dir[root.join("app/assets/javascripts/**/*")]
    initializer 'rails_charts.assets' do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.precompile += PRECOMPILE_ASSETS
      end
    end

    initializer 'rails_charts.helpers', before: :load_config_initializers do
      ActiveSupport.on_load :action_view do
        include RailsCharts::Helpers
      end
    end

  end
end
