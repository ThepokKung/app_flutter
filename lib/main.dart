import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                height: 150,
                child: Row(
                  children: [
                    Text("อุณหภมิ = ", style: TextStyle(fontSize: 25, color: Colors.white),),
                    Text(""),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
                height: 150,
                child: Row(
                  children: [
                    Text("ความชื้น = ", style: TextStyle(fontSize: 25, color: Colors.white),),
                    Text(""),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15)),
                height: 150,
                child: Row(
                  children: [
                    Text("PM2.5 = ", style: TextStyle(fontSize: 25, color: Colors.white),),
                    Text("")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
