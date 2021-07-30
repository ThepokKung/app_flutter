import 'package:flutter/material.dart';
import 'Widget/Test_widget.dart';
import 'Class/all_value.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'graph_sceen/humidity/graph_humidity.dart';
import 'graph_sceen/pm2.5/graph_pm.dart';
import 'graph_sceen/temp/graph_temp.dart';
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

  void _loading_status_false() {
    setState(() {
      _loading = false;
    });
  }

  Stream<List<dynamic>> aloneValueStream() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 1000));
      var apiUrl =
          "http://180.180.216.61/final-project/all/flutter_api/nt_node_app_api/test_api_copy.php";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        jsonData['results'].forEach((result) {
          // result['series'] is List
          var seriesList = List<Series>.from(
              result['series'].map((x) => Series.fromJson(x)));
          series.addAll(seriesList);
          return series;
        });
      } else {
        setState(() {
          _loading = true;
        });
        break;
      }
      _loadedData = series;
      yvalue1 = [];
      yvalue2 = [];
      yvalue3 = [];
      for (var i = 0; i < _loadedData[0].values.length; i++) {
        yvalue1.add(_loadedData[0].values[i][3].toDouble());
        yvalue2.add(_loadedData[0].values[i][2].toDouble());
        yvalue3.add(_loadedData[0].values[i][1].toDouble());
      }
      yield _loadedData;
      yield yvalue1;
      yield yvalue2;
      yield yvalue3;
      _loading_status_false();
      series = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading...' : 'NT Node Sensor'),
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
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return graph_temp();
                                  }));
                                  }, child:
                                Test_guage("อุณหภูมิ", Colors.orange.shade700,
                                    _loadedData[0].values[0][2]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return graph_pm();
                                  }));
                                  }, child:
                                Test_guage("PM2.5", Colors.brown,
                                    _loadedData[0].values[0][1]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return graph_humidity();
                                  }));
                                  }, child:
                                Test_guage("ความชิ้น", Colors.blue.shade700,
                                    _loadedData[0].values[0][3]),
                                    ),
                                SizedBox(
                                  height: 5,
                                ),

                                Graph_Widget(
                                    graph_value1,
                                    Colors.blue.shade700,
                                    graph_value2,
                                    Colors.orange.shade700,
                                    graph_value3,
                                    Colors.brown,
                                    Colors.grey),
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
