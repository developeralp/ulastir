import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulastir/models/api/bus_direction.dart';
import 'package:ulastir/models/api/bus_line.dart';
import 'package:ulastir/models/api/bus_station.dart';
import 'package:ulastir/models/temp_bus_route.dart';

class TempBusRouteNotifier extends StateNotifier<TempBusRoute> {
  TempBusRouteNotifier()
      : super(TempBusRoute(
          line: BusLine(),
          direction: BusDirection(),
          directions: [],
          station: BusStation(),
          stations: [],
        ));

  void setLine(BusLine line) {
    state = TempBusRoute(
      line: line,
      direction: BusDirection(),
      directions: [],
      station: BusStation(),
      stations: [],
    );
  }

  void setDirection(BusDirection direction) {
    state = state.copyWith(
        direction: direction, stations: direction.data?.stations ?? []);
  }

  void setStation(BusStation station) {
    state = state.copyWith(station: station);
  }
}
