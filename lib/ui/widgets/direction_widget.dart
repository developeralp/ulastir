import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/ui/navigations.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/ui/auto_complete/auto_complete_text_field.dart';
import 'package:ulastir/ui/auto_complete/skeleton_auto_complete.dart';
import 'package:ulastir/ui/designer.dart';
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
      margin: EdgeInsets.symmetric(vertical: 16.h),
      decoration: Designer.outlinedContainer,
      padding: EdgeInsets.all(32.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Yolculuk nereye?',
          style: GoogleFonts.abel(fontSize: 84.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30.h,
        ),
        savedRoutes.when(
            loading: () => const SkeletonAutoComplete(),
            error: ((error, stackTrace) => Text('Hata: $error')),
            data: (savedRoutes) {
              return AutoCompleteTextField(
                  mainPageWidth: true,
                  enabled: true,
                  items: savedRoutes.map((e) => e.name).toList(),
                  hintText: 'Gidilecek yeri girin...',
                  icon: Icons.navigation_outlined,
                  onSelected: (index) => NavigationUtils.openNavigationPage(
                      context: context, savedRoute: savedRoutes[index]));
            }),
      ]),
    );
  }
}
