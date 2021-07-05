import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user-list.dart';
import 'CarList.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    gettestdata();
    //futureCarlist = fetchCarlist();
  }

  Future<void> gettestdata() async {
    var response2 = await http.get(Uri.parse(
        'http://180.180.216.61/final-project/all/flutter_api/api_get_data_test_2.php'));
    print(response2.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: CarList(),
      ),
    );
  }
}
