// To parse this JSON data, do
//
//     final railStation = railStationFromJson(jsonString);

import 'dart:convert';

List<RailStation> railStationsFromJson(String str) => List<RailStation>.from(
    json.decode(str).map((x) => RailStation.fromJson(x)));

String railStationsToJson(List<RailStation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RailStation {
  int? id;
  int? stationId;
  String? name;
  String? code;

  RailStation({
    this.id,
    this.stationId,
    this.name,
    this.code,
  });

  factory RailStation.fromJson(Map<String, dynamic> json) => RailStation(
        id: json["id"],
        stationId: json["station_id"],
        name: json["station_name"],
        code: json["station_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "station_id": stationId,
        "station_name": name,
        "station_code": code,
      };
}
