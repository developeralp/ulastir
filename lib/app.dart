import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/pages/home_page.dart';
import 'package:ulastir/pages/travel_page.dart';
import 'package:ulastir/pages/route_stuff/route_designer_page.dart';
import 'package:ulastir/pages/route_stuff/bus_route_creator_page.dart';
import 'package:ulastir/ui/misc/scroll_behaviors.dart';

class UlastirApp extends StatelessWidget {
  const UlastirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          scrollBehavior: ScrollBehaviors(),
          initialRoute: Navigations.home,
          routes: {
            '/': (context) => const HomePage(),
            Navigations.routeDesigner: (context) => const RouteDesignerPage(),
            Navigations.busRouteCreator: (context) =>
                const BusRouteCreatorPage(),
            Navigations.navigation: (context) => const TravelPage(),
          },
          title: 'Ulaştır',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
          ),
        );
      },
    );
  }
}
