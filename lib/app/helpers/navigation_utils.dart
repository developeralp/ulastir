import 'package:flutter/material.dart';
import 'package:ulastir/common/data/models/saved_route.dart';
import 'package:ulastir/features/route_designer/route_designer_page.dart';
import 'package:ulastir/app/routes/navigations.dart';
import 'package:ulastir/app/helpers/routes_io.dart';

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
