import 'package:flutter/material.dart';
import 'package:ulastir/models/saved_route.dart';

class StationResult implements Comparable<StationResult> {
  List list = [];
  Line? routeObj;

  StationResult({required this.list, this.routeObj});

  bool get active => list.isNotEmpty;

  @override
  int compareTo(StationResult other) {
    StationTime? ourFirstStationTime =
        list.whereType<StationTime>().firstOrNull;

    StationTime? theirFirstStationTime =
        other.list.whereType<StationTime>().firstOrNull;

    if (ourFirstStationTime != null && theirFirstStationTime != null) {
      int ourHour = int.parse(ourFirstStationTime.time.split(':')[0]);
      int ourMinute = int.parse(ourFirstStationTime.time.split(':')[1]);

      int theirHour = int.parse(theirFirstStationTime.time.split(':')[0]);
      int theirMinute = int.parse(theirFirstStationTime.time.split(':')[1]);

      TimeOfDay ourTime = TimeOfDay(hour: ourHour, minute: ourMinute);

      TimeOfDay theirTime = TimeOfDay(hour: theirHour, minute: theirMinute);

      int ourSec = (ourTime.hour * 60 + ourTime.minute) * 60;
      int theirSec = (theirTime.hour * 60 + theirTime.minute) * 60;

      if (ourSec > theirSec) {
        return 1;
      } else {
        return -1;
      }
    }

    return 0;
  }
}

class StationTime {
  final String time;
  StationTime({required this.time});
}

class StationOrItem {}

class StationVehicleItem {}
