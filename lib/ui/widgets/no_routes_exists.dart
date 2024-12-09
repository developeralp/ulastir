import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/widgets/add_new_route.dart';
import 'package:ulastir/utils/localizer.dart';

class NoRoutesExistsWidget extends StatelessWidget {
  const NoRoutesExistsWidget({super.key, required this.updateLastRoute});

  final Function updateLastRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: Designer.outlinedContainer,
      child: Column(
        children: [
          Text(
            '🧐',
            style: TextStyle(
              fontSize: 120.sp,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(Localizer.i.text('no_route_exists_yet'),
              style: TextStyle(
                fontSize: 56.sp,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: 32.h,
          ),
          AddNewRouteButton(
            updateRoutes: () {
              updateLastRoute();
            },
          ),
        ],
      ),
    );
  }
}
