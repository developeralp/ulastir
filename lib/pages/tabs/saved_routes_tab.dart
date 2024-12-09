import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/dialogs.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/ui/widgets/add_new_route.dart';
import 'package:ulastir/ui/widgets/no_routes_exists2.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/routes_io.dart';
import 'package:ulastir/utils/navigation_utils.dart';

final savedRoutesProvider =
    FutureProvider.autoDispose<List<SavedRoute>>((ref) async {
  return await RoutesIO().getAll();
});

class SavedRoutesTab extends ConsumerStatefulWidget {
  const SavedRoutesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedRoutesTabState();
}

class _SavedRoutesTabState extends ConsumerState<SavedRoutesTab> {
  void updateSavedRoutes() {
    ref.invalidate(savedRoutesProvider);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<SavedRoute>> savedRoutes = ref.watch(savedRoutesProvider);

    return Container(
      margin: EdgeInsets.all(28.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          savedRoutes.when(
            error: ((error, stackTrace) =>
                Text('${Localizer.i.text('error')} $error')),
            loading: () => const SkeletonAutoComplete(),
            data: (savedRoutes) {
              if (savedRoutes.isEmpty) {
                return const NoRouteExists2Widget();
              }

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: savedRoutes.length,
                  itemBuilder: (context, index) {
                    return SavedRouteWidget(
                        savedRoute: savedRoutes[index],
                        updateProvider: () {
                          updateSavedRoutes();
                        });
                  });
            },
          ),
          const Spacer(),
          AddNewRouteButton(
            updateRoutes: () {
              updateSavedRoutes();
            },
          ),
        ],
      ),
    );
  }
}

class SavedRouteWidget extends StatefulWidget {
  const SavedRouteWidget(
      {super.key, required this.savedRoute, required this.updateProvider});

  final SavedRoute savedRoute;
  final Function updateProvider;

  @override
  State<SavedRouteWidget> createState() => _SavedRouteWidgetState();
}

class _SavedRouteWidgetState extends State<SavedRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          onTap: () => NavigationUtils.openTravelPage(
              context: context, savedRoute: widget.savedRoute),
          child: Container(
              padding: EdgeInsets.all(32.w),
              decoration: Designer.outlinedContainer,
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      widget.savedRoute.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 58.sp,
                          color: Designer.textColor),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: askDeleteSavedRoute,
                      icon: Icon(
                        Designer.darkMode ? Icons.delete : Icons.delete_forever,
                        color: Designer.darkMode
                            ? Colors.red[400]
                            : Colors.red[800],
                        size: 62.w,
                      ),
                    ),
                  )
                ],
              ))),
      const Slack(),
    ]);
  }

  void askDeleteSavedRoute() {
    Dialogs.askDialog(
        context: context,
        title: Localizer.i.text('ask_delete_saved_route'),
        onYes: () async {
          await RoutesIO().remove(widget.savedRoute);
          widget.updateProvider();
        });
  }
}
