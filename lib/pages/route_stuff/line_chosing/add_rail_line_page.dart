import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/api/rail_direction.dart';
import 'package:ulastir/models/api/rail_line.dart';
import 'package:ulastir/models/api/rail_station.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/auto_complete/auto_complete_text_field.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/easy_snackbar.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/ui/widgets/ulastir_app_bar.dart';
import 'package:ulastir/rest_api/burulas_api.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/string_utils.dart';

//lineChoice
//directionChoice
//stationChoice

final lineChoiceProvider = StateProvider.autoDispose<RailLine>(
  (ref) => RailLine(),
);

final directionChoiceProvider = StateProvider.autoDispose<RailDirection>(
  (ref) => RailDirection(),
);

final stationChoiceProvider = StateProvider<RailStation>(
  (ref) => RailStation(),
);

//API Providers

final linesProvider = FutureProvider.autoDispose<List<RailLine>>((ref) async {
  return await BurulasApi().getAllRailLines();
});

final directionsProvider =
    FutureProvider.autoDispose<List<RailDirection>>((ref) async {
  final RailLine lineChoice = ref.watch(lineChoiceProvider);
  return await BurulasApi().getRailDirections(lineChoice);
});

final stationsProvider =
    FutureProvider.autoDispose<List<RailStation>>((ref) async {
  final RailDirection direction = ref.watch(directionChoiceProvider);

  return await BurulasApi().getRailStations(direction: direction);
});

class AddRailLinePage extends ConsumerStatefulWidget {
  const AddRailLinePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddRailLinePageState();
}

class _AddRailLinePageState extends ConsumerState<AddRailLinePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RailLine>> lines = ref.watch(linesProvider);
    AsyncValue<List<RailDirection>> directions = ref.watch(directionsProvider);
    AsyncValue<List<RailStation>> stations = ref.watch(stationsProvider);

    RailLine line = ref.watch(lineChoiceProvider);
    RailDirection direction = ref.watch(directionChoiceProvider);
    RailStation station = ref.watch(stationChoiceProvider);

    return Scaffold(
        backgroundColor: Designer.backgroundColor,
        appBar: UlastirAppBar(title: Localizer.i.text('add_rail_line')),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(30.w),
              child: Form(
                child: Column(children: [
                  lines.when(
                      loading: () => const SkeletonAutoComplete(),
                      error: ((error, stackTrace) =>
                          Text('${Localizer.i.text('error')}: $error')),
                      data: (lines) {
                        return AutoCompleteTextField(
                          defaultValue: line.name ?? '',
                          enabled: (lines.isNotEmpty),
                          items: lines.map((e) => e.name ?? '').toList(),
                          hintText: Localizer.i.text('search_rail_lines'),
                          icon: Icons.directions_train,
                          onSelected: (index) => updateLine(lines[index]),
                        );
                      }),
                  const Slack(),
                  directions.when(
                      loading: () => const SkeletonAutoComplete(),
                      error: ((error, stackTrace) =>
                          Text('${Localizer.i.text('error')}: $error')),
                      data: (directions) {
                        return AutoCompleteTextField(
                            defaultValue: direction.name ?? '',
                            enabled: (directions.isNotEmpty),
                            icon: Icons.alt_route,
                            items: directions.map((e) => e.name ?? '').toList(),
                            hintText: Localizer.i.text('search_directions'),
                            onSelected: (index) =>
                                updateDirection(directions[index]));
                      }),
                  const Slack(),
                  stations.when(
                    loading: () => const SkeletonAutoComplete(),
                    error: ((error, stackTrace) =>
                        Text('${Localizer.i.text('error')}: $error')),
                    data: (stations) {
                      return AutoCompleteTextField(
                          defaultValue: station.name ?? '',
                          enabled: (stations.isNotEmpty),
                          icon: Icons.add_road,
                          items: stations.map((e) => e.name ?? '').toList(),
                          hintText: Localizer.i.text('search_rail_lines'),
                          onSelected: (index) =>
                              updateStation(stations[index]));
                    },
                  ),
                  const Slack(),
                  OutlinedButton.icon(
                      style: Designer.outlinedButton,
                      icon: const Icon(Icons.directions),
                      onPressed: () => addRoute(),
                      label: const Text('HATTI EKLEYİN')),
                ]),
              )),
        ));
  }

  void updateLine(RailLine line) {
    ref.read(lineChoiceProvider.notifier).update((state) => line);
    _checkAndClearDirection();
    _checkAndClearStation();
  }

  void updateDirection(RailDirection direction) {
    ref.read(directionChoiceProvider.notifier).update((state) => direction);
    _checkAndClearStation();
  }

  void updateStation(RailStation station) {
    ref.read(stationChoiceProvider.notifier).update((state) => station);
  }

  void _checkAndClearDirection() {
    RailDirection direction = ref.read(directionChoiceProvider);
    if (direction.id != null) {
      ref
          .read(directionChoiceProvider.notifier)
          .update((state) => RailDirection());
    }
  }

  void _checkAndClearStation() {
    RailStation station = ref.read(stationChoiceProvider);
    if (station.id != null) {
      ref.read(stationChoiceProvider.notifier).update((state) => RailStation());
    }
  }

  void addRoute() {
    RailDirection direction = ref.read(directionChoiceProvider);
    RailLine line = ref.read(lineChoiceProvider);
    RailStation station = ref.read(stationChoiceProvider);

    if (line.id == null || direction.id == null || station.id == null) {
      EasySnackbar.show(
          context: context, text: Localizer.i.text('line_add_err'));
      return;
    }

    ref.read(stationChoiceProvider.notifier).update((state) => RailStation());

    Line routeObj = Line(
        id: StringUtils.getRandomString(16),
        type: Lines.rail,
        lineId: line.id ?? 0,
        lineName: line.name ?? '',
        directionId: direction.id ?? 0,
        directionName: direction.name ?? '',
        stationId: station.id ?? 0,
        stationName: station.name ?? '');

    Navigator.pop(context, routeObj);
  }
}
