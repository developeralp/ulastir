import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulastir/models/saved_route.dart';

class LinesNotifier extends StateNotifier<List<Line>> {
  LinesNotifier() : super([]);

  void add(var add) {
    state = [...state, add];
  }

  void removeRoute(String id) {
    state = [
      for (final routeObj in state)
        if (routeObj.id != id) routeObj,
    ];
  }
}
