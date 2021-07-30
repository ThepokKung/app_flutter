import 'package:flutter/material.dart';
import 'graph_pm.dart';
import 'graph_pm_w.dart';
import 'graph_pm_m.dart';
import 'package:nt_node_sensor/main.dart';

class graph_pm_y extends StatelessWidget {
  const graph_pm_y({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PM2.5"),
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
                  return graph_pm();
                }));
              }, child: Text("วัน")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_pm_w();
                }));
              }, child: Text("สัปดาห์")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_pm_m();
                }));
              }, child: Text("เดือน")),
            ),
            ListTile(
              title: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return graph_pm_y();
                }));
              }, child: Text("ปี")),
            ),
          ],
          )
      ),
    );
  }
}