import 'package:flutter/material.dart';
import 'graph_humidity.dart';
import 'graph_humidity_m.dart';
import 'graph_humidity_y.dart';
import 'package:nt_node_sensor/main.dart';

class graph_humidity_w extends StatelessWidget {
  const graph_humidity_w({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความชื้น"),
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
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_humidity();
                }));
              }, child: Text("วัน")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_humidity_w();
                }));
              }, child: Text("สัปดาห์")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_humidity_m();
                }));
              }, child: Text("เดือน")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_humidity_y();
                }));
              }, child: Text("ปี")),
            ),
          ],
          )
      ),
    );
  }
}