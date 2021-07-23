import 'package:flutter/material.dart';
import 'package:flutter_application_3/Widget/Test_widget.dart';
import 'Class/all_value.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    //Test_fetchData();
    _fetchData();
  }

  Future<void> _fetchData() async {
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

    setState(() {
      _loading = false;
      _loadedData = series;
    });
  }

  Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;
      if (i == maxCount) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'NT Node Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _loading == true
              ? Center(
                  child: TestWidget("Loading....", "Data", 150, Colors.blue),
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
                    TestWidget("PM2.5", _loadedData[0].values[0][1].toString(),
                        150, Colors.purple),
                  ],
                ),
        ),
      ),
    );
  }
}
