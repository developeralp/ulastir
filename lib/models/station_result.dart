import 'package:ulastir/models/saved_route.dart';

class StationResult {
  List list = [];
  RouteObj? routeObj;

  StationResult({required this.list, this.routeObj});
}

class StationTime {
  final String time;
  StationTime({required this.time});
}

class StationOrItem {}

class StationVehicleItem {}
