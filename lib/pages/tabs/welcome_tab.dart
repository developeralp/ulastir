import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/station_result.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/ui/widgets/direction_widget.dart';
import 'package:ulastir/ui/widgets/how_to_use_widget.dart';
import 'package:ulastir/ui/widgets/last_route_widget.dart';
import 'package:ulastir/ui/widgets/no_routes_exists.dart';
import 'package:ulastir/ui/widgets/quick_last_route_widget.dart';
import 'package:ulastir/ui/widgets/quick_last_route_widget_skeleton.dart';
import 'package:ulastir/rest_api/burulas_api.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/routes_io.dart';
import 'package:ulastir/utils/navigation_utils.dart';

final lastRouteProvider = FutureProvider.autoDispose<SavedRoute>((ref) async {
  return await RoutesIO().getLast();
});

final lastRouteTimesProvider =
    FutureProvider.autoDispose<StationResult?>((ref) async {
  SavedRoute savedRoute =
      await ref.watch(lastRouteProvider.selectAsync((data) => data));

  if (savedRoute.lines.isEmpty) {
    return Future.value(StationResult(list: []));
  } else {
    Line last = savedRoute.lines[0];
    return await BurulasApi().getRouteTimes(last, welcomeTab: true);
  }
});

final showHowToUseProvider = FutureProvider.autoDispose<bool>((ref) async {
  var sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getBool('show_how_to_use') ?? true;
});

class WelcomeTab extends ConsumerStatefulWidget {
  const WelcomeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeTabState();
}

class _WelcomeTabState extends ConsumerState<WelcomeTab> {
  late SavedRoute _savedRoute;

  void updateLastRoute() {
    ref.invalidate(lastRouteProvider);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<SavedRoute> lastRoute = ref.watch(lastRouteProvider);
    AsyncValue<StationResult?> lastRouteTimes =
        ref.watch(lastRouteTimesProvider);

    AsyncValue<bool> showHowToUse = ref.watch(showHowToUseProvider);

    return Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const DirectionWidget(),
            showHowToUse.when(
                loading: () => Text(Localizer.i.text('please_wait')),
                error: ((error, stackTrace) =>
                    Text('${Localizer.i.text('error')}: $error')),
                data: (show) {
                  if (show) {
                    return Column(
                      children: [
                        const Slack(),
                        HowToUseWidget(
                          updateProvider: () {
                            ref.invalidate(showHowToUseProvider);
                          },
                        ),
                      ],
                    );
                  }

                  return Container();
                }),
            const Spacer(),
            lastRoute.when(
              loading: () => Text(Localizer.i.text('please_wait')),
              error: ((error, stackTrace) =>
                  Text('${Localizer.i.text('error')}: $error')),
              data: (lastRoute) {
                if (lastRoute.id.isEmpty) {
                  return NoRoutesExistsWidget(updateLastRoute: () {
                    updateLastRoute();
                  });
                }

                _savedRoute = lastRoute;

                return LastRouteWidget(
                    name: lastRoute.name,
                    open: () {
                      NavigationUtils.openTravelPage(
                          context: context, savedRoute: lastRoute);
                    });
              },
            ),
            lastRouteTimes.when(
              loading: () => const QuickLastRouteWidgetSkeleton(),
              error: ((error, stackTrace) =>
                  Text('${Localizer.i.text('error')}: $error')),
              data: (stationResult) {
                if (stationResult == null) return Container();

                if (stationResult.list.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuickLastRouteWidget(
                        result: stationResult,
                        open: () async {
                          NavigationUtils.openTravelPage(
                              context: context, savedRoute: _savedRoute);
                        }),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
