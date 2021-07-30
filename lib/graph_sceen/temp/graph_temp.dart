import 'package:flutter/material.dart';
import 'graph_temp_w.dart';
import 'graph_temp_m.dart';
import 'graph_temp_y.dart';
import 'package:nt_node_sensor/main.dart';

class graph_temp extends StatelessWidget {
  const graph_temp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("อุณหภูมิแบบวัน"),
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
                  return MyApp();
                }));
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return graph_temp();
                  }));
                }, child: Text("อุณหภูมิแบบวัน")),
              ),
              ListTile(
                title: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return graph_temp_w();
                  }));
                }, child: Text("อุณหภูมิแบบสัปดาห์")),
              ),
              ListTile(
                title: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return graph_temp_m();
                  }));
                }, child: Text("อุณหภูมิแบบเดือน")),
              ),
              ListTile(
                title: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return graph_temp_y();
                  }));
                }, child: Text("อุณหภูมิแบบปี")),
              ),
            ],
            ),
        )
      ),
    );
  }
}