/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "src/application.css"
import BarChart from "charts/bar_chart"
import BarChartConfig from "charts/bar_chart_config"
import GroupedBarChart from "charts/grouped_bar_chart"
import GroupedBarChartConfig from "charts/grouped_bar_chart_config"
import MultiLineChart from "charts/multi_line_chart"
import MultiLineChartConfig from "charts/multi_line_chart_config"

document.addEventListener("turbolinks:load", function (){

  let barCharts = document.querySelectorAll("[data-viz='bar-chart']")
  for (var chartElement of barCharts) {
    let config = BarChartConfig.from(chartElement)
    let b = new BarChart(chartElement, config);
    b.render();
  }

  let groupedBarCharts = document.querySelectorAll("[data-viz='grouped-bar-chart']")
  for (var chartElement of groupedBarCharts) {
    let config = GroupedBarChartConfig.from(chartElement)
    let b = new GroupedBarChart(chartElement, config);
    b.render();
  }

  let multiLineCharts = document.querySelectorAll("[data-viz='multi-line-chart']")
  for (var chartElement of multiLineCharts) {
    let config = MultiLineChartConfig.from(chartElement)
    let b = new MultiLineChart(chartElement, config);
    b.render();
  }
})
