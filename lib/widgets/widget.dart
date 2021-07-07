import 'package:flutter/material.dart';
import 'package:flutter_app_http/screens/test.dart';

class TestWidget extends StatelessWidget {
  String textinfo;
  String value;
  double size;
  Color color;
  String check_color = "ว่าง";

  TestWidget(this.textinfo, this.value, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    if (value == check_color) {
      color = Colors.grey;
      value = "ไม่มีคนใช้งาน";
    } else {
      color = Colors.green;
      value = "มีคนใช้งาน";
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      height: size,
      child: ListTile(
        title: Text(
          textinfo,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 25),
        ),
        //onTap: Navigator(screens/test.dart),
      ),
    );
  }
}
