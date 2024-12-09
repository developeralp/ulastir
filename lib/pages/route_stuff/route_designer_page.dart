import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulastir/ui/easy_snackbar.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/riverpod/lines_notifier.dart';
import 'package:ulastir/ui/widgets/custom_outlined_button.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/dialogs.dart';
import 'package:ulastir/ui/widgets/route_design_widget.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/routes_io.dart';
import 'package:ulastir/utils/string_utils.dart';

final nameProvider = StateProvider<String>(
  (ref) => '',
);

final linesProvider =
    StateNotifierProvider.autoDispose<LinesNotifier, List<Line>>((ref) {
  return LinesNotifier();
});

class RouteDesignerPage extends ConsumerStatefulWidget {
  const RouteDesignerPage({super.key, this.updateRoutes});

  final Function? updateRoutes;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteDesignerPageState();
}

class _RouteDesignerPageState extends ConsumerState<RouteDesignerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Line> lines = ref.watch(linesProvider);

    return Scaffold(
        backgroundColor: Designer.backgroundColor,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              Localizer.i.text('route_designer'),
              style: GoogleFonts.staatliches(fontSize: 68.sp),
            )),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(28.w),
          child: Column(children: [
            TextFormField(
                onChanged: (value) {
                  ref.read(nameProvider.notifier).update((state) => value);
                },
                decoration: Designer.outlinedTextField(
                    label: Localizer.i.text('route_name'),
                    icon: Icons.transfer_within_a_station)),
            if (lines.isNotEmpty)
              RouteDesignWidget(
                lines: lines,
                askDeleteRoute: (routeID) => askDeleteRoute(routeID),
              ),
            if (lines.isEmpty) const Slack(),
            SizedBox(
                width: double.infinity,
                child: CustomOutlinedButton(
                  icon: Icons.directions_bus_filled,
                  title: Localizer.i.text('add_bus_line'),
                  onClicked: () => addBusLine(),
                )),
            const Slack(),
            SizedBox(
                width: double.infinity,
                child: CustomOutlinedButton(
                  icon: Icons.directions_railway_filled,
                  title: Localizer.i.text('add_rail_line'),
                  onClicked: () => addRailLine(),
                )),
            const Spacer(),
            Center(
              child: OutlinedButton.icon(
                  style: Designer.outlinedButton,
                  icon: const Icon(Icons.save_rounded),
                  onPressed: () => saveRoute(),
                  label: Text(
                    Localizer.i.text('save'),
                  )),
            ),
          ]),
        )));
  }

  askDeleteRoute(String routeID) {
    Dialogs.askDialog(
        context: context,
        title: Localizer.i.text('ask_delete_saved_route'),
        onYes: () {
          ref.read(linesProvider.notifier).removeRoute(routeID);
        });
  }

  addBusLine() {
    _createRoute(type: Lines.bus);
  }

  addRailLine() {
    _createRoute(type: Lines.rail);
  }

  _createRoute({
    required Lines type,
  }) {
    Navigator.of(context)
        .pushNamed(type == Lines.bus
            ? Navigations.busRouteCreator
            : Navigations.railRouteCreator)
        .then((line) {
      if (line != null && line is Line) {
        ref.read(linesProvider.notifier).add(line);
      }
    });
  }

  saveRoute() async {
    List<Line> lines = ref.read(linesProvider);
    String name = ref.read(nameProvider);

    if (lines.isEmpty) {
      EasySnackbar.show(
          context: context, text: Localizer.i.text('route_save_err_add_line'));
      return;
    }

    if (name.isEmpty) {
      EasySnackbar.show(
          context: context, text: Localizer.i.text('route_save_err_add_name'));

      return;
    }
    RoutesIO()
        .add(SavedRoute(
      id: StringUtils.getRandomString(16),
      name: name,
      lines: lines,
    ))
        .then((value) {
      if (widget.updateRoutes != null) {
        widget.updateRoutes!();
      }

      Navigator.pop(context);
    });
  }
}
