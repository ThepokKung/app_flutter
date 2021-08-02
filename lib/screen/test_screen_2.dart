import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../main.dart';
import '../../Class/value_for_graph.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test_screen_2 extends StatelessWidget {
  //const Test_screen_2({Key? key}) : super(key: key);
  bool _loading = true;
  List<Series> series = [];
  List _loadedData = [];
  List<FlSpot> graph_value = [];
  List<dynamic> yvalue = [];

  @override
  void initState() {
    //super.initState();
    _loading = true;
  }

  void _loading_status_false() {
    _loading = false;
  }

  Stream<List<dynamic>> test_value() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 2000));
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
        _loading_status_false();
        break;
      }
      _loadedData = series;
      yvalue = [];
      for (var i = 0; i < _loadedData[0].values.length; i++) {
        yvalue.add(_loadedData[0].values[i][1].toDouble());
      }
      yield _loadedData;
      _loading_status_false();
      series = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test screen"),
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
                  stream: test_value(),
                  builder: (context, snapshot) {
                    print("rander Test object");
                    return Center(
                      child: _loading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [],
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
