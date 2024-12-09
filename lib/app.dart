import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulastir/pages/route_stuff/line_chosing/add_bus_line_page.dart';
import 'package:ulastir/pages/route_stuff/line_chosing/add_rail_line_page.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/pages/home_page.dart';
import 'package:ulastir/pages/travel_page.dart';
import 'package:ulastir/pages/route_stuff/route_designer_page.dart';
import 'package:ulastir/ui/misc/scroll_behaviors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ulastir/utils/localizer.dart';

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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalizerDelegate(),
          ],
          supportedLocales: const [Locale('en', ''), Locale('tr', '')],
          scrollBehavior: ScrollBehaviors(),
          initialRoute: Navigations.home,
          routes: {
            '/': (context) => const HomePage(),
            Navigations.routeDesigner: (context) => const RouteDesignerPage(),
            Navigations.busRouteCreator: (context) => const AddBusLinePage(),
            Navigations.railRouteCreator: (context) => const AddRailLinePage(),
            Navigations.travel: (context) => const TravelPage(),
          },
          title: 'Ulaştır',
          theme: ThemeData(
            useMaterial3: false,
            brightness: Designer.darkMode ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.deepPurple,
            textTheme: GoogleFonts.lexendTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
        );
      },
    );
  }
}
