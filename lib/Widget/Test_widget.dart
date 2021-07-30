import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class BoxWidget extends StatelessWidget {
  String textinfo;
  String value;
  double size;
  Color color;
  BoxWidget(this.textinfo, this.value, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      height: 150,
      child: Row(
        children: [
          Text(
            textinfo,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          Expanded(
            child: Text(
              " " + value,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class Graph_Widget extends StatelessWidget {
  List<FlSpot> value1;
  List<FlSpot> value2;
  List<FlSpot> value3;
  Color value1color;
  Color value2color;
  Color value3color;
  Color bgcolor;

  Graph_Widget(this.value1, this.value1color, this.value2, this.value2color,
      this.value3, this.value3color, this.bgcolor);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        height: 300,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: value1,
                isCurved: true,
                barWidth: 3,
                colors: [
                  value1color,
                ],
              ),
              LineChartBarData(
                spots: value2,
                isCurved: true,
                barWidth: 3,
                colors: [
                  value2color,
                ],
              ),
              LineChartBarData(
                spots: value3,
                isCurved: true,
                barWidth: 3,
                colors: [
                  value3color,
                ],
              )
            ],
          ),
        ));
  }
}

class Test_guage extends StatelessWidget {
  String title;
  Color bgcolor;
  dynamic value;
  Test_guage(this.title, this.bgcolor, this.value);
  @override
  Widget build(BuildContext context) {
    double value_d = value.toDouble();
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        height: 300,
        child: SfRadialGauge(
          title: GaugeTitle(
              text: title,
              textStyle: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              alignment: GaugeAlignment.center),
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 100, color: Colors.lightBlue),
            ], pointers: <GaugePointer>[
              RangePointer(value: value_d, cornerStyle: CornerStyle.bothCurve),
              NeedlePointer(value: value_d)
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Container(
                      child: Text(NumberFormat("##.##").format(value),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ],
        ));
  }
}
