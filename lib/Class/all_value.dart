import 'dart:convert';

import 'package:flutter/cupertino.dart';

AllValue allValueFromJson(String str) => AllValue.fromJson(json.decode(str));

String allValueToJson(AllValue data) => json.encode(data.toJson());

class AllValue {
  AllValue({
    required this.results,
  });

  final List<Result> results;

  factory AllValue.fromJson(Map<String, dynamic> json) => AllValue(
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

  final int statementId;
  final List<Series> series;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        statementId: json["statement_id"],
        series:
            List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statement_id": statementId,
        "series": List<Series>.from(series.map((x) => x.toJson())),
      };
}

class Series {
    Series({
        required this.name,
        required this.columns,
        required this.values,
    });

    final String name;
    final List<String> columns;
    final List<List<dynamic>> values;

    factory Series.fromJson(Map<String, dynamic> json) => Series(
        name: json["name"],
        columns: List<String>.from(json["columns"].map((x) => x)),
        values: List<List<dynamic>>.from(json["values"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "columns": List<dynamic>.from(columns.map((x) => x)),
        "values": List<dynamic>.from(values.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
