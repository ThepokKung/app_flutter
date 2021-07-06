import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

/*
final String apiUrl =
    "http://180.180.216.61/final-project/all/flutter_api/api_get_data_test_2.php";

Future<List<dynamic>> fetchCarList() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    /*
    final jsonResponse = jsonDecode(response.body);
    String jsonsDataString = jsonResponse.toString();
    return json.decode(jsonsDataString);
    */
    //return dynamic jsonDecode(jsonDecode(response.body));
    return json.decode(response.body)['results'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

String _productTitle(dynamic carlist) {
  return carlist['productTitle'];
}

String _availability(dynamic carlist) {
  return carlist['availability'];
}

/*
List<Carlist> carlistFromJson(String str) => List<Carlist>.from(json.decode(str).map((x) => Carlist.fromJson(x)));

String carlistToJson(List<Carlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carlist {
    Carlist({
        required this.productTitle,
        required this.availability,
    });

    String productTitle;
    String availability;

    factory Carlist.fromJson(Map<String, dynamic> json) => Carlist(
        productTitle: json["ProductTitle"],
        availability: json["Availability"],
    );

    Map<String, dynamic> toJson() => {
        "ProductTitle": productTitle,
        "Availability": availability,
    };
}
*/
*/
class CarList extends StatelessWidget {
  final String apiUrl =
      "http://180.180.216.61/final-project/all/flutter_api/api_get_data_test_2.php";
  
  Future<List<dynamic>> fetchCarList() async {
    var response = await http.get(Uri.parse(apiUrl));
    final jsonResponse = jsonDecode(response.body);
    String jsonsDataString = jsonResponse.toString();
    return jsonDecode(jsonsDataString);

    //return json.decode(result.body)['results'];
  }

  String _productTitle(dynamic carlist) {
    return carlist['productTitle'];
  }

  String _availability(dynamic carlist) {
    return carlist['availability'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: fetchCarList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(_availability(snapshot.data[0]));
            return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(_availability(snapshot.data[index])),
                          subtitle: Text(_productTitle(snapshot.data[index])),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
