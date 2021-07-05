// To parse this JSON data, do
//
//     final carlist = carlistFromJson(jsonString);
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

final String apiUrl =
    "http://180.180.216.61/final-project/all/flutter_api/api_get_data_test.php";

Future<Carlist> fetchCarList() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonResponse = jsonDecode(response.body);
    return Carlist.fromJson(jsonResponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Carlist carlistFromJson(String str) => Carlist.fromJson(json.decode(str));

String carlistToJson(Carlist data) => json.encode(data.toJson());

class Carlist {
  Carlist({
    required this.id,
    required this.catId,
    required this.productTitle,
    required this.availability,
    required this.image,
    required this.creationDate,
    required this.province,
    required this.deviceId,
  });

  String id;
  String catId;
  String productTitle;
  String availability;
  String image;
  DateTime creationDate;
  String province;
  String deviceId;

  factory Carlist.fromJson(Map<String, dynamic> json) => Carlist(
        id: json["ID"],
        catId: json["CatID"],
        productTitle: json["ProductTitle"],
        availability: json["Availability"],
        image: json["Image"],
        creationDate: DateTime.parse(json["CreationDate"]),
        province: json["province"],
        deviceId: json["deviceID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CatID": catId,
        "ProductTitle": productTitle,
        "Availability": availability,
        "Image": image,
        "CreationDate": creationDate.toIso8601String(),
        "province": province,
        "deviceID": deviceId,
      };
}

class CarList extends StatelessWidget {
  //const CarList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Carlist>(
        future: fetchCarList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.availability);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
