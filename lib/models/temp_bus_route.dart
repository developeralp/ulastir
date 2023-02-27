import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ulastir/models/api/bus_direction.dart';
import 'package:ulastir/models/api/bus_line.dart';
import 'package:ulastir/models/api/bus_station.dart';

part 'temp_bus_route.freezed.dart';

@freezed
class TempBusRoute with _$TempBusRoute {
  const factory TempBusRoute({
    required BusLine line,
    required BusDirection direction,
    required List<BusDirection> directions,
    required BusStation station,
    required List<BusStation> stations,
  }) = _TempBusRoute;
}
