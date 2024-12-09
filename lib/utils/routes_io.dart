import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/models/saved_route.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class RoutesIO {
  Future<List<SavedRoute>> get _savedRoutesFile async {
    String data = localStorage.getItem('saved_routes') ?? '';

    if (data.isEmpty) {
      return [];
    }

    return savedRoutesFromJson(data);
  }

  _saveRoutes(List<SavedRoute> savedRoutes) async {
    final json = savedRoutesToJson(savedRoutes);
    localStorage.setItem('saved_routes', json);
  }

  Future<void> add(SavedRoute savedRoute) async {
    List<SavedRoute> savedRoutes = await _savedRoutesFile;
    savedRoutes.add(savedRoute);

    if (savedRoutes.length == 1) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('lastRouteID', savedRoute.id);
    }

    _saveRoutes(savedRoutes);
  }

  Future<void> remove(SavedRoute savedRoute) async {
    List<SavedRoute> savedRoutes = await _savedRoutesFile;
    SavedRoute? find =
        savedRoutes.firstWhereOrNull((element) => element.id == savedRoute.id);

    if (find != null) {
      savedRoutes.remove(find);
    }

    _saveRoutes(savedRoutes);
  }

  Future<List<SavedRoute>> getAll() async {
    return await _savedRoutesFile;
  }

  Future<SavedRoute> getLast() async {
    List<SavedRoute> savedRoutes = await getAll();

    if (savedRoutes.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      var lastRouteID = prefs.getString('lastRouteID');

      if (lastRouteID != null) {
        SavedRoute? find = savedRoutes
            .firstWhereOrNull((element) => element.id == lastRouteID);

        if (find != null) {
          return Future.value(find);
        }
      }
    }

    return Future.value(SavedRoute(id: '', name: '', lines: []));
  }

  Future<void> setCurrentTravel(SavedRoute? savedRoute) async {
    if (savedRoute == null) return;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastRouteID', savedRoute.id);
  }
}
