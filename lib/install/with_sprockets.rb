js_code = <<~JS
  //= require echarts.min.js
  //= require echarts/theme/vintage.js
JS

if Rails.root.join("app/assets/javascripts/application.js").exist?
  say "Import ECharts"
  append_to_file "app/assets/javascripts/application.js", js_code
else
  say "You must import add these lines in your JavaScript entrypoint file", :red
  say js_code
end
