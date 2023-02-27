import 'package:flutter/material.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/utils/routes_io.dart';

class NavigationUtils {
  static void openNavigationPage(
      {required BuildContext context, required SavedRoute savedRoute}) {
    RoutesIO().saveLatestRoute(savedRoute).then((value) {
      Navigator.pushNamed(context, Navigations.navigation);
    });
  }
}
