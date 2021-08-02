// To parse this JSON data, do
//
//     final valueForGraph = valueForGraphFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ValueForGraph valueForGraphFromJson(String str) =>
    ValueForGraph.fromJson(json.decode(str));

String valueForGraphToJson(ValueForGraph data) => json.encode(data.toJson());

class ValueForGraph {
  ValueForGraph({
    required this.results,
  });

  List<Result> results;

  factory ValueForGraph.fromJson(Map<String, dynamic> json) => ValueForGraph(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.statementId,
    required this.series,
  });

  int statementId;
  List<Series> series;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        statementId: json["statement_id"],
        series:
            List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statement_id": statementId,
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
      };
}

class Series {
  Series({
    required this.name,
    required this.columns,
    required this.values,
  });

  String name;
  List<String> columns;
  List<List<dynamic>> values;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        name: json["name"],
        columns: List<String>.from(json["columns"].map((x) => x)),
        values: List<List<dynamic>>.from(
            json["values"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "columns": List<dynamic>.from(columns.map((x) => x)),
        "values": List<dynamic>.from(
            values.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
