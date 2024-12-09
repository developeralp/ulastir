// To parse this JSON data, do
//
//     final railLinesResponse = railLinesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ulastir/models/api/rail_direction.dart';

List<RailLine> railLinesFromJson(String str) =>
    List<RailLine>.from(json.decode(str).map((x) => RailLine.fromJson(x)));

String railLinesToJson(List<RailLine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RailLine {
  int? id;
  String? name;
  String? code;
  List<RailDirection>? directions;
  List<Day>? days;

  RailLine({
    this.id,
    this.name,
    this.code,
    this.directions,
    this.days,
  });

  factory RailLine.fromJson(Map<String, dynamic> json) => RailLine(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        directions: List<RailDirection>.from(
            json["directions"].map((x) => RailDirection.fromJson(x))),
        days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "directions":
            List<dynamic>.from(directions?.map((x) => x.toJson()) ?? []),
        "days": List<dynamic>.from(days?.map((x) => x.toJson()) ?? []),
      };
}

class Day {
  String? friday;
  String? monday;
  String? saturday;
  String? sunday;
  String? thursday;
  String? tuesday;
  String? wednesday;

  Day({
    this.friday,
    this.monday,
    this.saturday,
    this.sunday,
    this.thursday,
    this.tuesday,
    this.wednesday,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        friday: json["FRIDAY"],
        monday: json["MONDAY"],
        saturday: json["SATURDAY"],
        sunday: json["SUNDAY"],
        thursday: json["THURSDAY"],
        tuesday: json["TUESDAY"],
        wednesday: json["WEDNESDAY"],
      );

  Map<String, dynamic> toJson() => {
        "FRIDAY": friday,
        "MONDAY": monday,
        "SATURDAY": saturday,
        "SUNDAY": sunday,
        "THURSDAY": thursday,
        "TUESDAY": tuesday,
        "WEDNESDAY": wednesday,
      };
}
