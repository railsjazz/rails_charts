say "Import ECharts"
append_to_file "app/javascript/application.js", <<~JS
  import "echarts"
  import "echarts/theme/dark"
JS

say "Pin ECharts"
append_to_file "config/importmap.rb", <<~RUBY
  pin "echarts", to: "echarts.min.js"
  pin "echarts/theme/dark", to: "echarts/theme/dark.js"
RUBY
