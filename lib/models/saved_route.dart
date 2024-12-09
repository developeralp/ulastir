// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

import 'package:ulastir/models/enums/lines.dart';

List<SavedRoute> savedRoutesFromJson(String str) =>
    List<SavedRoute>.from(json.decode(str).map((x) => SavedRoute.fromJson(x)));

String savedRoutesToJson(List<SavedRoute> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedRoute {
  SavedRoute({
    required this.id,
    required this.name,
    required this.lines,
  });

  String id;
  String name;
  List<Line> lines;

  factory SavedRoute.fromJson(Map<String, dynamic> json) => SavedRoute(
        id: json['id'] ?? '',
        name: json["name"],
        lines: List<Line>.from(json["lines"].map((x) => Line.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "name": name,
        "lines": List<dynamic>.from(lines.map((x) => x.toJson())),
      };
}

class Line {
  Line({
    required this.id,
    required this.type,
    this.lineId,
    this.lineName,
    this.directionId,
    this.directionName,
    this.stationId,
    this.stationName,
    this.travelTime,
  });

  String id;
  Lines type;
  int? lineId;
  String? lineName;
  int? directionId;
  String? directionName;
  int? stationId;
  String? stationName;
  int? travelTime;

  String get lineNameShort =>
      (lineName?.split(' ')[0].replaceAll('(', '').replaceAll(')', '') ?? '');

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        id: json["id"],
        type: Lines.values.byName(json["type"]),
        lineId: json["lineId"] ?? 0,
        lineName: json["lineName"] ?? '',
        directionId: json['directionId'] ?? 0,
        directionName: json["directionName"] ?? '',
        stationId: json["stationId"] ?? '',
        stationName: json["stationName"] ?? '',
        travelTime: json["travelTime"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type.name,
        "lineId": lineId ?? 0,
        "lineName": lineName ?? '',
        "directionId": directionId ?? 0,
        "directionName": directionName ?? '',
        "stationId": stationId ?? 0,
        "stationName": stationName ?? '',
        "travelTime": travelTime ?? 0,
      };
}
