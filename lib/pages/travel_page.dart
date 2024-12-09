import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/station_result.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/widgets/route_navigation_grid_widget.dart';
import 'package:ulastir/ui/widgets/ulastir_app_bar.dart';
import 'package:ulastir/rest_api/burulas_api.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/routes_io.dart';

final travelProvider = FutureProvider.autoDispose<SavedRoute>((ref) async {
  SavedRoute route = await RoutesIO().getLast();
  return route;
});

final lastRouteTimesProvider =
    FutureProvider.autoDispose<List<StationResult>>((ref) async {
  SavedRoute savedRoute =
      await ref.watch(travelProvider.selectAsync((data) => data));

  if (savedRoute.lines.isEmpty) {
    return Future.value([]);
  } else {
    return await BurulasApi().getSavedRouteTimes(savedRoute);
  }
});

class TravelPage extends ConsumerStatefulWidget {
  const TravelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends ConsumerState<TravelPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<StationResult>> stationResults =
        ref.watch(lastRouteTimesProvider);

    return Scaffold(
      backgroundColor: Designer.backgroundColor,
      appBar: UlastirAppBar(title: Localizer.i.text('route')),
      body: Container(
          padding: EdgeInsets.all(20.w),
          child: stationResults.when(
            error: ((error, stackTrace) =>
                Text('${Localizer.i.text('error_occurred')} $error')),
            loading: () => const SizedBox(
              height: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            ),
            data: (stationResults) {
              return ListView.builder(
                  itemCount: stationResults.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: RouteNavigationGridWidget(
                            index: index, result: stationResults[index]));
                  });
            },
          )),
    );
  }
}
