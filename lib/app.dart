import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulastir/features/route_designer/line_chosing/add_bus_line_page.dart';
import 'package:ulastir/features/route_designer/line_chosing/add_rail_line_page.dart';
import 'package:ulastir/app/theme/designer.dart';
import 'package:ulastir/app/routes/navigations.dart';
import 'package:ulastir/features/home/home_page.dart';
import 'package:ulastir/features/travel/travel_page.dart';
import 'package:ulastir/features/route_designer/route_designer_page.dart';
import 'package:ulastir/common/ui/scroll_behaviors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ulastir/app/helpers/localizer.dart';

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
