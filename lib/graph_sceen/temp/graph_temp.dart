import 'package:flutter/material.dart';
import 'graph_temp_w.dart';
import 'graph_temp_m.dart';
import 'graph_temp_y.dart';
import 'package:nt_node_sensor/main.dart';
import '../../Widget/Test_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../Class/value_for_graph.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class graph_temp extends StatelessWidget {
  List _loadedData = [];
  List<Series> series = [];
  bool _loading = true;
  List<FlSpot> graph_value1 = [];
  List<dynamic> yvalue = [];

  @override
  void initState() {
    _loading = true;
  }

  void _loading_status_false() {
    _loading = false;
  }

  void _loading_status_true() {
    _loading = true;
  }

  Stream<List<dynamic>> valueStream() async* {
    while (true) {
      await Future.delayed(Duration(minutes: 30));
      var apiUrl =
          "http://180.180.216.61/final-project/all/flutter_api/nt_node_app_api/test_api_copy.php";
      //var apiUrl = "http://180.180.216.61/final-project/all/flutter_api/nt_node_app_api/temp/1d-temp-api.php"
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
        _loading_status_true();
        break;
      }
      _loadedData = series;
      yvalue = [];
      for (var i = 0; i < _loadedData[0].values.length; i++) {
        yvalue.add(_loadedData[0].values[i][3].toDouble());
      }
      yield _loadedData;
      yield yvalue;
      _loading_status_false();
      series = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("อุณหภูมิแบบวัน"),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyApp();
            }));
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: StreamBuilder(
                  stream: valueStream(),
                  builder: (context, snapshot) {
                    print('render - connter widget ๅ ');
                    List<FlSpot> graph_value1 = yvalue.asMap().entries.map((e) {
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
                                graph_one_value_widget(graph_value1,
                                    Colors.orange.shade700, Colors.grey)
                              ],
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ), //data here
      endDrawer: Drawer(
          child: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return graph_temp();
                    }));
                  },
                  child: Text("อุณหภูมิแบบวัน")),
            ),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return graph_temp_w();
                    }));
                  },
                  child: Text("อุณหภูมิแบบสัปดาห์")),
            ),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return graph_temp_m();
                    }));
                  },
                  child: Text("อุณหภูมิแบบเดือน")),
            ),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return graph_temp_y();
                    }));
                  },
                  child: Text("อุณหภูมิแบบปี")),
            ),
          ],
        ),
      )),
    );
  }
}
