export default class MultiLineChartConfig {
  static from(element){
    let url = element.dataset.url
    let yAxis = element.dataset.yAxisLabel
    let xAxis = element.dataset.xAxisLabel

    return new MultiLineChartConfig(url, yAxis, xAxis);
  }

  constructor(url, yAxisLabel, xAxisLabel) {
    this.url = url;
    this.yAxisLabel = yAxisLabel;
    this.xAxisLabel = xAxisLabel;
  }
}
