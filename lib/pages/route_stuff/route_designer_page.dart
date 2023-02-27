import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/models/enums/route_obj_types.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/riverpod/routes_notifier.dart';
import 'package:ulastir/ui/widgets/custom_outlined_button.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/dialogs.dart';
import 'package:ulastir/ui/widgets/route_design_widget.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/utils/routes_io.dart';
import 'package:ulastir/utils/string_utils.dart';

final routeNameProvider = StateProvider<String>(
  (ref) => '',
);

final routesProvider =
    StateNotifierProvider<RoutesNotifier, List<RouteObj>>((ref) {
  return RoutesNotifier();
});

class RouteDesignerPage extends ConsumerStatefulWidget {
  const RouteDesignerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteDesignerPageState();
}

class _RouteDesignerPageState extends ConsumerState<RouteDesignerPage> {
  @override
  void initState() {
    super.initState();
    ref.read(routeNameProvider.notifier).update((state) => '');
  }

  @override
  Widget build(BuildContext context) {
    List<RouteObj> routes = ref.watch(routesProvider);

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'YOLCULUK PLANLAYICI',
              style: GoogleFonts.staatliches(fontSize: 68.sp),
            )),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(children: [
            TextFormField(
                onChanged: (value) {
                  ref.read(routeNameProvider.notifier).update((state) => value);
                },
                decoration: Designer.outlinedTextField(
                    label: 'Yolculuk Adı',
                    icon: Icons.transfer_within_a_station)),
            if (routes.isNotEmpty)
              RouteDesignWidget(
                routes: routes,
                askDeleteRoute: (routeID) => askDeleteRoute(routeID),
              ),
            if (routes.isEmpty) const Slack(),
            SizedBox(
                width: double.infinity,
                child: CustomOutlinedButton(
                  icon: Icons.directions,
                  title: 'ROTA EKLE',
                  onClicked: () => addRoute(),
                )),
            const Slack(),
            if (routes.isNotEmpty)
              SizedBox(
                  width: double.infinity,
                  child: CustomOutlinedButton(
                    icon: Icons.assistant_direction_sharp,
                    title: 'ALTERNATİF ROTA EKLE',
                    onClicked: () => addRoute(alternative: true),
                  )),
            const Spacer(),
            Center(
              child: OutlinedButton.icon(
                  style: Designer.outlinedButton,
                  icon: const Icon(Icons.save_rounded),
                  onPressed: () => saveRoute(),
                  label: const Text('KAYDET')),
            ),
          ]),
        )));
  }

  askDeleteRoute(String routeID) {
    Dialogs.askDialog(
        context: context,
        title: 'Rotayı silmek istiyor musunuz?',
        onYes: () {
          ref.read(routesProvider.notifier).removeRoute(routeID);
        });
  }

  addRoute({bool? alternative}) {
    if (alternative != null) {
      if (alternative) {
        return _addRoute(alternative: true);
      }
    }

    _addRoute();
  }

  _addRoute({RouteObj? travelObj, bool alternative = false}) {
    Navigator.of(context)
        .pushNamed(Navigations.busRouteCreator)
        .then((routeObj) {
      if (routeObj != null && routeObj is RouteObj) {
        if (travelObj != null) {
          ref.read(routesProvider.notifier).add(travelObj);
        }

        if (alternative) {
          ref
              .read(routesProvider.notifier)
              .add(RouteObj(id: routeObj.id, type: RouteObjTypes.or));
        }

        ref.read(routesProvider.notifier).add(routeObj);
      }
    });
  }

  saveRoute() {
    List<RouteObj> routes = ref.read(routesProvider);
    String routeName = ref.read(routeNameProvider);

    if (routes.isEmpty) {
      Dialogs.showAlert(
          context: context,
          title: 'Hata',
          text: 'Yolculuğu kaydetmek için rota eklemeniz gerekiyor');
      return;
    }

    if (routeName.isEmpty) {
      Dialogs.showAlert(
          context: context,
          title: 'Hata',
          text: 'Yolculuğu kaydetmek için adını girmeniz gerekiyor');

      return;
    }

    log('kaydediliyor...');

    RoutesIO().add(SavedRoute(
      id: StringUtils.getRandomString(16),
      name: routeName,
      routes: routes,
    ));

    Navigator.pop(context);
  }
}
