import * as d3 from "d3";

export default class MultiLineChart {
  constructor(element, config) {
    this.element = element;
    this.config = config;
  }

  render(){
    let svg = d3.select(this.element);

    let margin = {top: 20, right: 80, bottom: 30, left: 50};
    let width = svg.attr("width") - margin.left - margin.right;
    let height = svg.attr("height") - margin.top - margin.bottom;
    let g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scaleLinear().range([0, width]),
        y = d3.scaleLinear().range([height, 0]),
        z = d3.scaleOrdinal(d3.schemeCategory10);

    var line = d3.line()
        .x(function(d) { console.log([d.id, d.result]); return x(d.id); })
        .y(function(d) { return y(d.result); });

    d3.json(this.config.url, (data) => {
      let events = data.map((athlete) => {
        return athlete.values.map((v) => {
          return v.id
        })
      });

      x.domain(d3.extent(events[0]));

      y.domain([
        d3.min(data, function(c) { return d3.min(c.values, function(d) { return d.result; }); }),
        d3.max(data, function(c) { return d3.max(c.values, function(d) { return d.result; }); })
      ]);

      z.domain(data.map(function(d) { return d.id; }));

      g.append("g")
          .attr("class", "axis axis--x")
          .attr("transform", "translate(0," + height + ")")
          .call(d3.axisBottom(x).ticks(20));

      g.append("g")
          .attr("class", "axis axis--y")
          .call(d3.axisLeft(y))
        .append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", "0.71em")
          .attr("fill", "#000")
          .text();

      var athlete = g.selectAll(".athlete")
        .data(data)
        .enter().append("g")
          .attr("class", "athlete");

      athlete.append("path")
          .attr("class", "line")
          .attr("d", function(d) { return line(d.values); })
          .style("stroke", function(d) { return z(d.id); });

      athlete.append("text")
          .datum(function(d) { return {id: d.id, value: d.values[d.values.length - 1]}; })
          .attr("transform", function(d) { return "translate(" + x(d.value.id) + "," + y(d.value.result) + ")"; })
          .attr("x", 3)
          .attr("dy", "0.35em")
          .style("font", "10px sans-serif")
          .text(function(d) { return d.id; });
    });
  }
}
