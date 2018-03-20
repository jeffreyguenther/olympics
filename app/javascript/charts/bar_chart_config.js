export default class BarChartConfig {
  static from(element){
    let url = element.dataset.url
    let barColor = element.dataset.barColor
    let yAxis = element.dataset.yAxisLabel
    let xAxis = element.dataset.xAxisLabel

    return new BarChartConfig(url, barColor, yAxis, xAxis);
  }

  constructor(url, barColor, yAxisLabel, xAxisLabel) {
    this.url = url;
    this.barColor = barColor;
    this.yAxisLabel = yAxisLabel;
    this.xAxisLabel = xAxisLabel;
  }
}
