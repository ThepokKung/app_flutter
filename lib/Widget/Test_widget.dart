import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  String textinfo;
  String value;
  double size;
  Color color;
  //String check_color = "ว่าง";

  TestWidget(this.textinfo, this.value, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      height: 150,
      child: Row(
        children: [
          Text(
            textinfo + " =",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          Text(
            " " + value,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
