import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulastir/common/data/models/saved_route.dart';

class LinesNotifier extends Notifier<List<Line>> {
  @override
  List<Line> build() {
    return [];
  }

  void add(Line line) {
    state = [...state, line];
  }

  void removeRoute(String id) {
    state = [
      for (final routeObj in state)
        if (routeObj.id != id) routeObj,
    ];
  }
}
