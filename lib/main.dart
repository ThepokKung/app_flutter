import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()
import 'widgets/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'test_fectData',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The list that contains information about photos
  List _loadedData = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL =
        'http://180.180.216.61/final-project/all/flutter_api/api_get_data_test.php';

    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);

    setState(() {
      _loadedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test FecthData'),
      ),
      body: Container(
        child: _loadedData.length == 0
            ? Center(
                child: ElevatedButton(
                  child: Text('Load Data'),
                  onPressed: _fetchData,
                ),
              )
            : ListView.builder(
                itemCount: _loadedData.length,
                itemBuilder: (BuildContext ctx, index) {
                  return TestWidget(_loadedData[index]['ProductTitle'],
                      _loadedData[index]["Availability"], 100, Colors.black);
                },
              ),
      ),
    );
  }
}
