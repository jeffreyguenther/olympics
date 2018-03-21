export default class GroupedBarChartConfig {
  static from(element){
    let url = element.dataset.url
    let barColors = element.dataset.barColors.split(",")
    let yAxisLabel = element.dataset.yAxisLabel
    let xAxisLabel = element.dataset.xAxisLabel
    let legendItems = element.dataset.legendItems.split(",")

    return new GroupedBarChartConfig(url, barColors, yAxisLabel, xAxisLabel, legendItems);
  }

  constructor(url, barColors, yAxisLabel, xAxisLabel, legendItems) {
    this.url = url;
    this.barColors = barColors;
    this.yAxisLabel = yAxisLabel;
    this.xAxisLabel = xAxisLabel;
    this.legendItems = legendItems;
  }
}
