import 'package:flutter/material.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/pages/route_stuff/route_designer_page.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/utils/routes_io.dart';

class NavigationUtils {
  static void openTravelPage(
      {required BuildContext context, required SavedRoute savedRoute}) {
    RoutesIO().setCurrentTravel(savedRoute).then((value) {
      Navigator.pushNamed(context, Navigations.travel);
    });
  }

  static void openRouteDesignPage(BuildContext context,
      {Function? updateRoutes}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RouteDesignerPage(updateRoutes: updateRoutes)));
  }
}
