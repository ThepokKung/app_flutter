import 'package:flutter/material.dart';

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
      color = Colors.pink;
    } else {
      color = Colors.green;
    }
    return Container(
      padding: const EdgeInsets.all(15.0),
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
      ),
    );
  }
}
