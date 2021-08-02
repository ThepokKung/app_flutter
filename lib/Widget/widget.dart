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
      ),
    );
  }
}

class graph_one_value_widget extends StatelessWidget {
  List<FlSpot> value = [];
  Color color;
  Color bgcolor;
  graph_one_value_widget(this.value, this.color, this.bgcolor);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        height: 500,
        //width: ,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: value,
                isCurved: true,
                barWidth: 3,
                colors: [
                  color,
                ],
              ),
            ],
          ),
        ));
  }
}

class graph_one_value_widget_2 extends StatelessWidget {
  List<FlSpot> value = [];
  Color color;
  Color bgcolor;
  graph_one_value_widget_2(this.value, this.color, this.bgcolor);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData:
                  LineTouchTooltipData(tooltipBgColor: Colors.blue.shade700),
              touchCallback: (LineTouchResponse touchResponse) {},
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(
              show: false,
            ),
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTextStyles: (value) =>
                        const TextStyle(color: Colors.white, fontSize: 16),
                    margin: 10)),
            lineBarsData: [
              LineChartBarData(
                spots: value,
                isCurved: true,
                barWidth: 3,
                colors: [
                  color,
                ],
              ),
            ],
          ),
        ));
  }
}

class Test_graph_data extends StatelessWidget {
  List<FlSpot> dummyData1 = [];
  List<FlSpot> dummyData2 = [];
  List<FlSpot> dummyData3 = [];

  Test_graph_data(this.dummyData1, this.dummyData2, this.dummyData3);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      height: 300,
      child: LineChart(LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white.withOpacity(0.8),
          ),
        ),
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 10,
            getTextStyles: (value) => const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            margin: 10,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Last';
                case 18:
                  return 'Old';
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 10:
                  return '10';
                case 20:
                  return '20';
                case 30:
                  return '30';
                case 40:
                  return '40';
                case 50:
                  return '50';
                case 60:
                  return '60';
                case 70:
                  return '70';
                case 80:
                  return '80';
                case 90:
                  return '90';
                case 100:
                  return '100';
                case 15:
                  return '15';
                case 25:
                  return '25';
                case 35:
                  return '35';
                case 45:
                  return '45';
                case 55:
                  return '55';
                case 65:
                  return '65';
                case 75:
                  return '75';
                case 85:
                  return '85';
                case 95:
                  return '95';
              }
              return '';
            },
            margin: 8,
            reservedSize: 10,
          ),
        ),
        borderData: FlBorderData(
          show: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: dummyData1,
            isCurved: true,
            barWidth: 3,
            colors: [
              Colors.blue.shade700,
            ],
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: dummyData2,
            isCurved: true,
            barWidth: 3,
            colors: [
              Colors.orange.shade700,
            ],
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: dummyData3,
            isCurved: true,
            barWidth: 3,
            colors: [
              Colors.brown,
            ],
            dotData: FlDotData(show: false),
          ),
        ],
      )),
    );
  }
}
