import 'package:flutter/material.dart';
import 'package:flutter_application_3/Widget/Test_widget.dart';
import 'Class/all_value.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'NT Node Sensor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _loadedData = [];
  List<Series> series = [];
  bool _loading = true;
  List<FlSpot> graph_value1 = [];
  List<FlSpot> graph_value2 = [];
  List<FlSpot> graph_value3 = [];
  List<double> yvalue1 = [];
  List<double> yvalue2 = [];
  List<double> yvalue3 = [];

  @override
  void initState() {
    super.initState();
    _loading = true;
    print("");
  }

  Stream<List<dynamic>> aloneValueStream() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 1000));
      var apiUrl =
          "http://180.180.216.61/final-project/all/flutter_api/test_api_limit10.php";
      var response = await http.get(Uri.parse(apiUrl));
      var jsonData = jsonDecode(response.body);

      // access to each element in results
      jsonData['results'].forEach((result) {
        // result['series'] is List
        var seriesList =
            List<Series>.from(result['series'].map((x) => Series.fromJson(x)));
        series.addAll(seriesList);
      });
      _loadedData = series;
      yvalue1 = [
        _loadedData[0].values[0][3].toDouble(),
        _loadedData[0].values[1][3].toDouble(),
        _loadedData[0].values[2][3].toDouble(),
        _loadedData[0].values[3][3].toDouble(),
        _loadedData[0].values[4][3].toDouble(),
        _loadedData[0].values[5][3].toDouble(),
        _loadedData[0].values[6][3].toDouble(),
        _loadedData[0].values[7][3].toDouble(),
        _loadedData[0].values[8][3].toDouble(),
        _loadedData[0].values[9][3].toDouble(),
      ];
      yvalue2 = [
        _loadedData[0].values[0][2].toDouble(),
        _loadedData[0].values[1][2].toDouble(),
        _loadedData[0].values[2][2].toDouble(),
        _loadedData[0].values[3][2].toDouble(),
        _loadedData[0].values[4][2].toDouble(),
        _loadedData[0].values[5][2].toDouble(),
        _loadedData[0].values[6][2].toDouble(),
        _loadedData[0].values[7][2].toDouble(),
        _loadedData[0].values[8][2].toDouble(),
        _loadedData[0].values[9][2].toDouble(),
      ];
      yvalue3 = [
        _loadedData[0].values[0][1].toDouble(),
        _loadedData[0].values[1][1].toDouble(),
        _loadedData[0].values[2][1].toDouble(),
        _loadedData[0].values[3][1].toDouble(),
        _loadedData[0].values[4][1].toDouble(),
        _loadedData[0].values[5][1].toDouble(),
        _loadedData[0].values[6][1].toDouble(),
        _loadedData[0].values[7][1].toDouble(),
        _loadedData[0].values[8][1].toDouble(),
        _loadedData[0].values[9][1].toDouble(),
      ];
      yield _loadedData;
      yield yvalue1;
      yield yvalue2;
      yield yvalue3;
      _loading = false;
      print("It's series");
      print(series);
      print("It's LoadData");
      print(_loadedData);
      print("It'time ");
      print(_loadedData[0].values[0][0]);
      series = [];
      print("It's Clear");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(/*_loading ? 'Loading...' : */ 'NT Node Sensor'),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: aloneValueStream(),
                  builder: (context, snapshot1) {
                    print('render - Counter Widget');
                    List<FlSpot> graph_value1 =
                        yvalue1.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList();

                    List<FlSpot> graph_value2 =
                        yvalue2.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList();

                    List<FlSpot> graph_value3 =
                        yvalue3.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList();
                    return Center(
                      child: _loading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                TestWidget(
                                    "อุณหภูมิ",
                                    _loadedData[0].values[0][2].toString(),
                                    150,
                                    Colors.orange.shade700),
                                SizedBox(
                                  height: 5,
                                ),
                                TestWidget(
                                    "ความชื้น",
                                    _loadedData[0].values[0][3].toString(),
                                    150,
                                    Colors.blue.shade700),
                                SizedBox(
                                  height: 5,
                                ),
                                TestWidget(
                                    "PM2.5",
                                    _loadedData[0].values[0][1].toString(),
                                    150,
                                    Colors.brown),
                                SizedBox(
                                  height: 5,
                                ),
                                Graph_Widget(
                                    graph_value1,
                                    Colors.orange.shade700,
                                    graph_value2,
                                    Colors.blue.shade700,
                                    graph_value3,
                                    Colors.brown,
                                    Colors.grey)
                              ],
                            ),
                    );
                  },
                ),
              )),
            ],
          ),
        ));
  }
}
