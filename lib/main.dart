import 'package:flutter/material.dart';
import 'package:flutter_application_3/Widget/Test_widget.dart';
import 'Class/all_value.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  List<Feature> features = [];
  List _loadedData_forGraph = [];

  @override
  void initState() {
    super.initState();
    _loading = true;
  }

  Stream<List<dynamic>> aloneValueStream() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 1000));
      var apiUrl =
          "http://180.180.216.61/final-project/all/flutter_api/test_api.php";
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
      yield _loadedData;
      _loading = false;
      print("It's series");
      print(series);
      print("It's LoadData");
      print(_loadedData);
      print("It'time ");
      print(_loadedData[0].values[0][0]);
      print("Test Limit 10");
      print(_loadedData[0].values);
      series = [];
      print("It's Clear");
    }
  }

  /*
  Stream<List<Feature>> GraphValueStream() async* {
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
      _loadedData_forGraph = series;
      _loading = false;

      final List<Feature> features = [
        Feature(
          title: "อุณหภูมิ",
          color: Colors.red,
          data: [
            _loadedData_forGraph[0].values[0][3].toDouble(),
            _loadedData_forGraph[0].values[1][3].toDouble() ,
            _loadedData_forGraph[0].values[2][3].toDouble(),
            _loadedData_forGraph[0].values[3][3].toDouble(),
            _loadedData_forGraph[0].values[4][3].toDouble(),
            _loadedData_forGraph[0].values[5][3].toDouble(),
            _loadedData_forGraph[0].values[6][3].toDouble(),
            _loadedData_forGraph[0].values[7][3].toDouble(),
            _loadedData_forGraph[0].values[8][3].toDouble(),
            _loadedData_forGraph[0].values[9][3].toDouble(),
          ],
        ),
        Feature(
          title: "ความชื้น",
          color: Colors.green,
          data: [
            _loadedData_forGraph[0].values[0][2].toDouble(),
            _loadedData_forGraph[0].values[1][2].toDouble(),
            _loadedData_forGraph[0].values[2][2].toDouble(),
            _loadedData_forGraph[0].values[3][2].toDouble(),
            _loadedData_forGraph[0].values[4][2].toDouble(),
            _loadedData_forGraph[0].values[5][2].toDouble(),
            _loadedData_forGraph[0].values[6][2].toDouble(),
            _loadedData_forGraph[0].values[7][2].toDouble(),
            _loadedData_forGraph[0].values[8][2].toDouble(),
            _loadedData_forGraph[0].values[9][2].toDouble(),
          ],
        ),
        Feature(
          title: "PM2.5",
          color: Colors.purple,
          data: [
            _loadedData_forGraph[0].values[0][1].toDouble(),
            _loadedData_forGraph[0].values[1][1].toDouble(),
            _loadedData_forGraph[0].values[2][1].toDouble(),
            _loadedData_forGraph[0].values[3][1].toDouble(),
            _loadedData_forGraph[0].values[4][1].toDouble(),
            _loadedData_forGraph[0].values[5][1].toDouble(),
            _loadedData_forGraph[0].values[6][1].toDouble(),
            _loadedData_forGraph[0].values[7][1].toDouble(),
            _loadedData_forGraph[0].values[8][1].toDouble(),
            _loadedData_forGraph[0].values[9][1].toDouble(),
          ],
        ),
      ];

      yield features;
    }
  }

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(/*_loading ? 'Loading...' : */ 'NT Node Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: aloneValueStream(),
          builder: (context, snapshot1) {
            print('render - Counter Widget');
            /*
            return StreamBuilder(
              stream: GraphValueStream(),
              builder: (context, snapshot2) {
                */
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
                                _loadedData[0].values[0][3].toString(),
                                150,
                                Colors.red),
                            SizedBox(
                              height: 5,
                            ),
                            TestWidget(
                                "ความชื้น",
                                _loadedData[0].values[0][2].toString(),
                                150,
                                Colors.green),
                            SizedBox(
                              height: 5,
                            ),
                            TestWidget(
                                "PM2.5",
                                _loadedData[0].values[0][1].toString(),
                                150,
                                Colors.purple),
                            SizedBox(
                              height: 5,
                            ),
                            /*
                            LineGraph(
                              features: features,
                              size: Size(380, 300),
                              labelX: [
                                'Day 1',
                                'Day 2',
                                'Day 3',
                                'Day 4',
                                'Day 5'
                              ],
                              labelY: ['20%', '40%', '60%', '80%', '100%'],
                              showDescription: false,
                              graphColor: Colors.black,
                              graphOpacity: 0.4,
                              verticalFeatureDirection: true,
                              descriptionHeight: 130,
                            ),
                            */
                          ],
                        ),
                );
              },
            //);
          //},
        ),
      ),
    );
  }
}
