import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/auto_complete/auto_complete_text_field.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';
import 'package:ulastir/utils/routes_io.dart';
import 'package:ulastir/utils/navigation_utils.dart';

final savedRoutesProvider =
    FutureProvider.autoDispose<List<SavedRoute>>((ref) async {
  return await RoutesIO().getAll();
});

class DirectionWidget extends ConsumerWidget {
  const DirectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<SavedRoute>> savedRoutes = ref.watch(savedRoutesProvider);

    return Container(
      width: double.infinity,
      decoration: Designer.outlinedContainer,
      padding: EdgeInsets.all(32.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          Localizer.i.text('welcome_where_are_u_headed'),
          style: TextStyle(
              fontSize: 52.sp,
              fontWeight: FontWeight.normal,
              color: Designer.textColor),
        ),
        SizedBox(
          height: 30.h,
        ),
        savedRoutes.when(
            loading: () => const SkeletonAutoComplete(),
            error: ((error, stackTrace) =>
                Text('${Localizer.i.text('error')}: $error')),
            data: (savedRoutes) {
              return AutoCompleteTextField(
                  mainPageWidth: true,
                  enabled: true,
                  items: savedRoutes.map((e) => e.name).toList(),
                  hintText: Localizer.i.text('enter_where_you_want_to_go'),
                  icon: Icons.navigation_outlined,
                  onSelected: (index) => NavigationUtils.openTravelPage(
                      context: context, savedRoute: savedRoutes[index]));
            }),
      ]),
    );
  }
}
