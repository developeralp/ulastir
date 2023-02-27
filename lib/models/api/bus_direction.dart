// To parse this JSON data, do
//
//     final busDirection = busDirectionFromJson(jsonString);

import 'dart:convert';

import 'package:ulastir/models/api/bus_station.dart';

List<BusDirection> busDirectionFromJson(String str) => List<BusDirection>.from(
    json.decode(str).map((x) => BusDirection.fromJson(x)));

String busDirectionToJson(List<BusDirection> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusDirection {
  BusDirection({
    this.id,
    this.text,
    this.data,
  });

  int? id;
  String? text;
  Data? data;

  factory BusDirection.fromJson(Map<String, dynamic> json) => BusDirection(
        id: json["id"],
        text: json["text"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "data": (data != null ? data?.toJson() : ''),
      };
}

class Data {
  Data({
    this.starting,
    this.ending,
    this.fee,
    this.refuced,
    this.student,
    required this.stations,
    //  required this.tracks,
  });

  String? starting;
  String? ending;
  double? fee;
  double? refuced;
  double? student;
  List<BusStation> stations;
  //List<String> tracks;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        starting: json["starting"],
        ending: json["ending"],
        fee: json["fee"].toDouble(),
        refuced: json["refuced"],
        student: json["student"].toDouble(),
        stations: List<BusStation>.from(
            json["stations"].map((x) => BusStation.fromJson(x))),
        //   tracks: List<String>.from(json["tracks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "starting": starting,
        "ending": ending,
        "fee": fee,
        "refuced": refuced,
        "student": student,
        "stations": List<dynamic>.from(stations.map((x) => x.toJson())),
        //  "tracks": List<dynamic>.from(tracks.map((x) => x)),
      };
}
