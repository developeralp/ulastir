import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ulastir/models/api/bus_direction.dart';
import 'package:ulastir/models/api/bus_line.dart';
import 'package:ulastir/models/api/bus_station.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:ulastir/models/api/rail_direction.dart';
import 'package:ulastir/models/api/rail_line.dart';
import 'package:ulastir/models/api/rail_station.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/models/station_result.dart';

import 'package:html/dom.dart' as dom;

class BurulasApi {
  final httpOK = 200;

  static String api = 'https://www.burulas.com.tr/api/';

  final Dio dio = Dio();

  String scheme = 'https';
  String host = 'www.burulas.com.tr';

  String apiURL(String call) {
    return Uri(scheme: scheme, host: host, path: 'api/$call').toString();
  }

  String _railApiUrl(String call) {
    return Uri(scheme: scheme, host: host, path: 'api/rail-systems/$call')
        .toString();
  }

  /*

  BURSARAY API

  */

  Future<List<RailLine>> getAllRailLines() async {
    try {
      var response = await dio.get(_railApiUrl('lines.php'));

      if (response.statusCode == httpOK) {
        List<RailLine> lines = [];

        for (var element in response.data) {
          lines.add(RailLine.fromJson(element));
        }

        return Future.value(lines);
      }
    } catch (err) {
      log(err.toString());
    }

    return Future.value([]);
  }

  Future<List<RailDirection>> getRailDirections(RailLine railLine) async {
    return Future.value(railLine.directions ?? []);
  }

  Future<List<RailStation>> getRailStations(
      {required RailDirection direction}) async {
    if (direction.id == null) return Future.value([]);

    try {
      String url =
          'https://www.burulas.com.tr/api/rail-systems/stations.php?id=${direction.id}';
      var response = await dio.get(url);

      if (response.statusCode == httpOK) {
        List<RailStation> stations = [];

        for (var element in response.data) {
          stations.add(RailStation.fromJson(element));
        }

        return Future.value(stations);
      }
    } catch (err) {
      log(err.toString());
    }

    return Future.value([]);
  }

  /*

  BUS API

  */

  Future<List<BusLine>> getAllBusLines() async {
    try {
      var response = await dio.post(apiURL('otobus-hat-al.php'));

      if (response.statusCode == httpOK) {
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

      if (response.statusCode == httpOK) {
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

    for (Line line in savedRoute.lines) {
      if (line.type == Lines.bus || line.type == Lines.rail) {
        StationResult? result = await getRouteTimes(line);

        if (result != null) {
          list.add(result);
        }
      }
    }

    list.sort();

    return Future.value(list);
  }

  Future<StationResult?> getRouteTimes(Line line,
      {bool welcomeTab = false}) async {
    StationResult stationResult = StationResult(list: [], routeObj: line);

    if (line.type == Lines.bus) {
      stationResult.list = await _getBusStationTimes(line, welcomeTab);
    } else if (line.type == Lines.rail) {
      stationResult.list = await _getRailStationTimes(line, welcomeTab);
    }

    return Future.value(stationResult);
  }

  Future<List> _getBusStationTimes(Line routeObj, bool welcomeTab) async {
    try {
      DateTime now = DateTime.now();
      String today = DateFormat('dd/MM/yyyy').format(now);

      var formData = FormData.fromMap({
        'line': routeObj.lineId ?? 0,
        'route': routeObj.directionId ?? 0,
        'station': routeObj.stationId ?? 0,
        'day': now.weekday,
      });

      if (routeObj.lineId == null ||
          routeObj.lineId == 0 ||
          routeObj.directionId == null ||
          routeObj.directionId == 0 ||
          routeObj.stationId == null ||
          routeObj.stationId == 0) {
        log('null');
        return Future.value([]);
      }

      var response =
          await dio.post(apiURL('otobus-sefer-al.php'), data: formData);

      dom.Document document = parse(response.toString());

      List<String> buses = _getHourResults(document);

      List availables = [];

      if (welcomeTab) {
        availables.add(StationVehicleItem());
      }

      for (String bus in buses) {
        DateTime tempDate = DateFormat("dd/MM/yyyy HH:mm").parse('$today $bus');
        if (tempDate.isAfter(now)) {
          availables.add(StationTime(time: bus));

          if (welcomeTab) {
            availables.add(StationOrItem());
          }
        }
      }

      if (welcomeTab) {
        if (availables[availables.length - 1] is StationOrItem) {
          availables.removeAt(availables.length - 1);
        }

        if (availables.length == 1 && availables[0] is StationVehicleItem) {
          return Future.value([]);
        }
      }

      return availables;
    } catch (e) {
      log(e.toString());

      return Future.value([]);
    }
  }

  Future<List> _getRailStationTimes(Line routeObj, bool welcomeTab) async {
    try {
      DateTime now = DateTime.now();
      String dayName = DateFormat('EEEE').format(now).toUpperCase();
      String today = DateFormat('dd/MM/yyyy').format(now);

      if (routeObj.lineId == null ||
          routeObj.lineId == 0 ||
          routeObj.directionId == null ||
          routeObj.directionId == 0 ||
          routeObj.stationId == null ||
          routeObj.stationId == 0) {
        log('null');
        return Future.value([]);
      }

      String url =
          'https://www.burulas.com.tr/api/rail-systems/times-raw.php?id=${routeObj.stationId}&day=$dayName';

      var response = await dio.get(url);

      dom.Document document = parse(response.toString());

      List<String> rails = _getHourResults(document);

      List availables = [];

      if (welcomeTab) {
        availables.add(StationVehicleItem());
      }

      for (String metro in rails) {
        DateTime tempDate =
            DateFormat("dd/MM/yyyy HH:mm").parse('$today $metro');
        if (tempDate.isAfter(now)) {
          availables.add(StationTime(time: metro));

          if (welcomeTab) {
            availables.add(StationOrItem());
          }
        }
      }

      if (welcomeTab) {
        if (availables[availables.length - 1] is StationOrItem) {
          availables.removeAt(availables.length - 1);
        }

        if (availables.length == 1 && availables[0] is StationVehicleItem) {
          return Future.value([]);
        }
      }

      return availables;
    } catch (e) {
      log(e.toString());

      return Future.value([]);
    }
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
