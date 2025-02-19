// To parse this JSON data, do
//
//     final areaModule = areaModuleFromMap(jsonString);

import 'dart:convert';

AreaModule areaModuleFromMap(String str) =>
    AreaModule.fromMap(json.decode(str));

String areaModuleToMap(AreaModule data) => json.encode(data.toMap());

class AreaModule {
  Data? data;
  String? message;

  AreaModule({
    this.data,
    this.message,
  });

  factory AreaModule.fromMap(Map<String, dynamic> json) => AreaModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  List<String>? results;

  Data({
    this.results,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        results: json["results"] == null
            ? []
            : List<String>.from(json["results"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "results":
            results == null ? [] : List<dynamic>.from(results!.map((x) => x)),
      };
}
