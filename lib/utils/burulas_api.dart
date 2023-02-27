import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ulastir/models/api/bus_direction.dart';
import 'package:ulastir/models/api/bus_line.dart';
import 'package:ulastir/models/api/bus_station.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/enums/route_obj_types.dart';
import 'package:ulastir/models/station_result.dart';

import 'package:html/dom.dart' as dom;

class BurulasApi {
  static String api = 'https://www.burulas.com.tr/api/';

  final Dio dio = Dio();

  String scheme = 'https';
  String host = 'www.burulas.com.tr';

  String apiURL(String call) {
    return Uri(scheme: scheme, host: host, path: 'api/$call').toString();
  }

  Future<List<BusLine>> getAllBusLines() async {
    try {
      var response = await dio.post(apiURL('otobus-hat-al.php'));

      if (response.statusCode == 200) {
        List<BusLine> lines = busLineFromJson(response.data);

        return Future.value(lines);
      }
    } catch (err) {
      log(err.toString());
    }

    return Future.value([]);
  }

  Future<List<BusDirection>> getBusDirections({required int line}) async {
    if (line == 0) return [];

    try {
      var response = await dio.post(
        apiURL('otobus-yon-al.php'),
        data: FormData.fromMap({'line': line}),
      );

      if (response.statusCode == 200) {
        List<BusDirection> directions = busDirectionFromJson(response.data);

        return Future.value(directions);
      }
    } catch (err) {
      log(err.toString());
    }

    return Future.value([]);
  }

  Future<List<BusStation>> getBusStations(
      {required BusDirection direction}) async {
    if (direction.data == null) return Future.value([]);

    await Future.delayed(const Duration(milliseconds: 5));

    return Future.value(direction.data?.stations ?? []);
  }

  Future<List<StationResult>> getSavedRouteTimes(SavedRoute savedRoute) async {
    List<StationResult> list = [];

    for (RouteObj obj in savedRoute.routes) {
      if (obj.type == RouteObjTypes.bus) {
        StationResult? result = await getRouteTimes(obj);

        if (result != null) {
          list.add(result);
        }
      }
    }

    return Future.value(list);
  }

  Future<StationResult?> getRouteTimes(RouteObj routeObj) async {
    StationResult stationResult = StationResult(list: [], routeObj: routeObj);

    try {
      DateTime now = DateTime.now();
      String today = DateFormat('dd/MM/yyyy').format(now);

      var formData = FormData.fromMap({
        'line': routeObj.lineId ?? 0,
        'route': routeObj.directionId ?? 0,
        'station': routeObj.stationId ?? 0,
        'day': now.weekday,
      });

      log({
        'line': routeObj.lineId ?? 0,
        'route': routeObj.directionId ?? 0,
        'station': routeObj.stationId ?? 0,
        'day': now.weekday,
      }.toString());

      if (routeObj.lineId == null ||
          routeObj.lineId == 0 ||
          routeObj.directionId == null ||
          routeObj.directionId == 0 ||
          routeObj.stationId == null ||
          routeObj.stationId == 0) {
        return Future.value(null);
      }

      var response =
          await dio.post(apiURL('otobus-sefer-al.php'), data: formData);

      dom.Document document = parse(response.toString());

      List<String> buses = _getHourResults(document);

      List availables = [];

      availables.add(StationVehicleItem());

      for (String bus in buses) {
        DateTime tempDate = DateFormat("dd/MM/yyyy HH:mm").parse('$today $bus');
        if (tempDate.isAfter(now)) {
          availables.add(StationTime(time: bus));
          availables.add(StationOrItem());
        }
      }

      stationResult.list = availables;
    } catch (e) {
      log(e.toString());
    }

    return Future.value(stationResult);
  }

  _getHourResults(dom.Document document) {
    List<String> result = [];

    var hourLines = document.getElementsByClassName('hour-line');

    for (var trBase in hourLines) {
      var td = trBase.getElementsByTagName('td')[1];
      var times = td.innerHtml.split(RegExp('\\s+'));
      result.addAll(times);
    }

    return result;
  }
}
