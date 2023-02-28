import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/api/bus_direction.dart';
import 'package:ulastir/models/api/bus_line.dart';
import 'package:ulastir/models/api/bus_station.dart';
import 'package:ulastir/models/enums/route_obj_types.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/auto_complete/auto_complete_text_field.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/dialogs.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/ui/widgets/ulastir_app_bar.dart';
import 'package:ulastir/utils/burulas_api.dart';
import 'package:ulastir/utils/string_utils.dart';

//lineChoice
//directionChoice
//stationChoice

final lineChoiceProvider = StateProvider.autoDispose<BusLine>(
  (ref) => BusLine(),
);

final directionChoiceProvider = StateProvider.autoDispose<BusDirection>(
  (ref) => BusDirection(),
);

final stationChoiceProvider = StateProvider<BusStation>(
  (ref) => BusStation(),
);

//API Providers

final linesProvider = FutureProvider.autoDispose<List<BusLine>>((ref) async {
  return await BurulasApi().getAllBusLines();
});

final directionsProvider =
    FutureProvider.autoDispose<List<BusDirection>>((ref) async {
  final int routeIndex = ref.watch(lineChoiceProvider).id ?? 0;
  return await BurulasApi().getBusDirections(line: routeIndex);
});

final stationsProvider =
    FutureProvider.autoDispose<List<BusStation>>((ref) async {
  final BusDirection direction = ref.watch(directionChoiceProvider);

  return await BurulasApi().getBusStations(direction: direction);
});

class BusRouteCreatorPage extends ConsumerStatefulWidget {
  const BusRouteCreatorPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusRouteCreatorPageState();
}

class _BusRouteCreatorPageState extends ConsumerState<BusRouteCreatorPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<BusLine>> lines = ref.watch(linesProvider);
    AsyncValue<List<BusDirection>> directions = ref.watch(directionsProvider);
    AsyncValue<List<BusStation>> stations = ref.watch(stationsProvider);

    BusLine line = ref.watch(lineChoiceProvider);
    BusDirection direction = ref.watch(directionChoiceProvider);
    BusStation station = ref.watch(stationChoiceProvider);

    return Scaffold(
        appBar: const UlastirAppBar(title: 'OTOBÜS ROTASI EKLEYİN'),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(30.w),
              child: Form(
                child: Column(children: [
                  lines.when(
                      loading: () => const SkeletonAutoComplete(),
                      error: ((error, stackTrace) => Text('Hata: $error')),
                      data: (lines) {
                        return AutoCompleteTextField(
                          defaultValue: line.text ?? '',
                          enabled: (lines.isNotEmpty),
                          items: lines.map((e) => e.text ?? '').toList(),
                          hintText: 'Hatları Arayın',
                          icon: Icons.directions_bus,
                          onSelected: (index) => updateLine(lines[index]),
                        );
                      }),
                  const Slack(),
                  directions.when(
                      loading: () => const SkeletonAutoComplete(),
                      error: ((error, stackTrace) => Text('Hata: $error')),
                      data: (directions) {
                        return AutoCompleteTextField(
                            defaultValue: direction.text ?? '',
                            enabled: (directions.isNotEmpty),
                            icon: Icons.alt_route,
                            items: directions.map((e) => e.text ?? '').toList(),
                            hintText: 'Yönleri Arayın',
                            onSelected: (index) =>
                                updateDirection(directions[index]));
                      }),
                  const Slack(),
                  stations.when(
                    loading: () => const SkeletonAutoComplete(),
                    error: ((error, stackTrace) => Text('Hata: $error')),
                    data: (stations) {
                      return AutoCompleteTextField(
                          defaultValue: station.name ?? '',
                          enabled: (stations.isNotEmpty),
                          icon: Icons.add_road,
                          items: stations.map((e) => e.name ?? '').toList(),
                          hintText: 'Durakları Arayın',
                          onSelected: (index) =>
                              updateStation(stations[index]));
                    },
                  ),
                  const Slack(),
                  OutlinedButton.icon(
                      style: Designer.outlinedButton,
                      icon: const Icon(Icons.directions),
                      onPressed: () => addRoute(),
                      label: const Text('ROTAYI EKLE')),
                ]),
              )),
        ));
  }

  void updateLine(BusLine line) {
    ref.read(lineChoiceProvider.notifier).update((state) => line);
    _checkAndClearDirection();
    _checkAndClearStation();
  }

  void updateDirection(BusDirection direction) {
    ref.read(directionChoiceProvider.notifier).update((state) => direction);
    _checkAndClearStation();
  }

  void updateStation(BusStation station) {
    ref.read(stationChoiceProvider.notifier).update((state) => station);
  }

  void _checkAndClearDirection() {
    BusDirection direction = ref.read(directionChoiceProvider);
    if (direction.data != null) {
      ref
          .read(directionChoiceProvider.notifier)
          .update((state) => BusDirection());
    }
  }

  void _checkAndClearStation() {
    BusStation station = ref.read(stationChoiceProvider);
    if (station.id != null) {
      ref.read(stationChoiceProvider.notifier).update((state) => BusStation());
    }
  }

  void addRoute() {
    BusDirection direction = ref.read(directionChoiceProvider);
    BusLine line = ref.read(lineChoiceProvider);
    BusStation station = ref.read(stationChoiceProvider);

    if (line.id == null || direction.id == null || station.id == null) {
      Dialogs.showAlert(
          context: context,
          title: 'Hata',
          text: 'Rotayı kaydetmek için bütün bilgileri girmeniz gerekiyor...');
      return;
    }

    ref.read(stationChoiceProvider.notifier).update((state) => BusStation());

    direction.data?.stations = [];

    RouteObj routeObj = RouteObj(
        id: StringUtils.getRandomString(16),
        type: RouteObjTypes.bus,
        lineId: line.id ?? 0,
        lineName: line.text ?? '',
        directionId: direction.id ?? 0,
        directionName: direction.text ?? '',
        stationId: station.id ?? 0,
        stationName: station.name ?? '');

    Navigator.pop(context, routeObj);
  }
}
