import * as d3 from "d3";

export default class BarChart {
  constructor(url) {
    this.url = url;
  }

  render(){
    let svg = d3.select("svg");
    let margin = {top: 20, right: 20, bottom: 30, left: 50};
    let width = +svg.attr("width") - margin.left - margin.right;
    let height = +svg.attr("height") - margin.top - margin.bottom;

    var x = d3.scaleBand().rangeRound([0, width]).padding(0.1),
        y = d3.scaleLinear().rangeRound([height, 0]);

    var g = svg.append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    d3.json(this.url, function(data) {
      x.domain(data.map(function(d) { return d.name; }));
      y.domain([0, d3.max(data, function(d) { return d.count; })]);

      g.append("g")
          .attr("class", "axis axis--x")
          .attr("transform", "translate(0," + height + ")")
          .call(d3.axisBottom(x));

      g.append("g")
          .attr("class", "axis axis--y")
          .call(d3.axisLeft(y).ticks(10))
        .append("text")
          .attr("class", "text-black fill-current")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", "0.71em")
          .attr("text-anchor", "end")
          .text("Wins");

      g.selectAll(".bar")
        .data(data)
        .enter().append("rect")
          .attr("class", "text-blue fill-current")
          .attr("x", function(d) { return x(d.name); })
          .attr("y", function(d) { return y(d.count); })
          .attr("width", x.bandwidth())
          .attr("height", function(d) { return height - y(d.count); });
    });
  }
}
