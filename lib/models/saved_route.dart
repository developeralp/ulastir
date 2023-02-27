// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

import 'package:ulastir/models/enums/route_obj_types.dart';

List<SavedRoute> savedRoutesFromJson(String str) =>
    List<SavedRoute>.from(json.decode(str).map((x) => SavedRoute.fromJson(x)));

String savedRoutesToJson(List<SavedRoute> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedRoute {
  SavedRoute({
    required this.id,
    required this.name,
    required this.routes,
  });

  String id;
  String name;
  List<RouteObj> routes;

  factory SavedRoute.fromJson(Map<String, dynamic> json) => SavedRoute(
        id: json['id'] ?? '',
        name: json["name"],
        routes: List<RouteObj>.from(
            json["routes"].map((x) => RouteObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "name": name,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class RouteObj {
  RouteObj({
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
  RouteObjTypes type;
  int? lineId;
  String? lineName;
  int? directionId;
  String? directionName;
  int? stationId;
  String? stationName;
  int? travelTime;

  bool get isVehicle =>
      (type == RouteObjTypes.bus || type == RouteObjTypes.train);

  String get lineNameShort =>
      (lineName?.split(' ')[0].replaceAll('(', '').replaceAll(')', '') ?? '');

  factory RouteObj.fromJson(Map<String, dynamic> json) => RouteObj(
        id: json["id"],
        type: RouteObjTypes.values.byName(json["type"]),
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
