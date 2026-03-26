// To parse this JSON data, do
//
//     final busRoute = busRouteFromJson(jsonString);

import 'dart:convert';

List<BusLine> busLineFromJson(String str) =>
    List<BusLine>.from(json.decode(str).map((x) => BusLine.fromJson(x)));

String busLineToJson(List<BusLine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusLine {
  BusLine({
    this.id,
    this.text,
  });

  int? id;
  String? text;

  factory BusLine.fromJson(Map<String, dynamic> json) => BusLine(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
