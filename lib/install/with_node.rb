js_code = <<~JS
  import * as echarts from "echarts";
  import "echarts/theme/dark";

  window.echarts = echarts;
JS

if Rails.root.join("app/javascript/application.js").exist?
  say "Import ECharts"
  append_to_file "app/javascript/application.js", js_code
elsif Rails.root.join("app/javascript/packs/application.js").exist?
  say "Import ECharts"
  append_to_file "app/javascript/packs/application.js", js_code
else
  say "You must import add these lines in your JavaScript entrypoint file", :red
  say js_code
end

say "Install ECharts"
run "yarn add echarts"
