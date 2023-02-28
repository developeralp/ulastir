import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/pages/route_stuff/route_designer_page.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/dialogs.dart';
import 'package:ulastir/ui/misc/slack.dart';
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
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<SavedRoute>> savedRoutes = ref.watch(savedRoutesProvider);

    return Container(
      margin: EdgeInsets.all(28.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          savedRoutes.when(
            error: ((error, stackTrace) => Text('Hata: $error')),
            loading: () => const SkeletonAutoComplete(),
            data: (savedRoutes) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: savedRoutes.length,
                  itemBuilder: (context, index) {
                    return SavedRouteWidget(savedRoute: savedRoutes[index]);
                  });
            },
          ),
          const Spacer(),
          OutlinedButton.icon(
              style: Designer.outlinedButton,
              icon: const Icon(Icons.alt_route_outlined),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RouteDesignerPage()));
              },
              label: const Text('YENİ YOLCULUK')),
        ],
      ),
    );
  }
}

class SavedRouteWidget extends StatefulWidget {
  const SavedRouteWidget({super.key, required this.savedRoute});

  final SavedRoute savedRoute;

  @override
  State<SavedRouteWidget> createState() => _SavedRouteWidgetState();
}

class _SavedRouteWidgetState extends State<SavedRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          onTap: () => NavigationUtils.openNavigationPage(
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
                          fontWeight: FontWeight.w500, fontSize: 58.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: askDeletesavedRoute,
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red[800],
                        size: 62.w,
                      ),
                    ),
                  )
                ],
              ))),
      const Slack(),
    ]);
  }

  void askDeletesavedRoute() {
    Dialogs.askDialog(
        context: context,
        title: 'Yolculuğu silmek istediğinize emin misiniz?',
        onYes: () {
          RoutesIO().remove(widget.savedRoute);
        });
  }
}
