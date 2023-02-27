import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/models/saved_route.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class RoutesIO {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _savedRoutesFile async {
    final path = await _localPath;
    return File('$path/savedRoutes.json');
  }

  Future<File> _mainFile() async {
    final file = await _savedRoutesFile;
    if (!(await file.exists())) {
      await file.writeAsString('[]');
    }
    return Future.value(file);
  }

  Future<void> add(SavedRoute savedRoute) async {
    final file = await _savedRoutesFile;
    var contents = await file.readAsString();

    if (contents.isEmpty || contents == '') {
      contents = '[]';
    }

    List<SavedRoute> savedRoutes = savedRoutesFromJson(contents);
    savedRoutes.add(savedRoute);

    final json = savedRoutesToJson(savedRoutes);
    file.writeAsString(json);
  }

  Future<void> remove(SavedRoute savedRoute) async {
    final file = await _mainFile();
    var contents = await file.readAsString();

    if (contents.isEmpty || contents == '') {
      contents = '[]';
    }

    List<SavedRoute> savedRoutes = savedRoutesFromJson(contents);
    SavedRoute? find =
        savedRoutes.firstWhereOrNull((element) => element.id == savedRoute.id);

    if (find != null) {
      savedRoutes.remove(find);
    }

    final json = savedRoutesToJson(savedRoutes);
    file.writeAsString(json);
  }

  Future<List<SavedRoute>> getAll() async {
    final file = await _mainFile();
    var contents = await file.readAsString();

    if (contents.isEmpty || contents == '') {
      return [];
    }

    return savedRoutesFromJson(contents);
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

    return Future.value(SavedRoute(id: '', name: '', routes: []));
  }

  Future<void> saveLatestRoute(SavedRoute? savedRoute) async {
    if (savedRoute == null) return;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastRouteID', savedRoute.id);
  }
}
