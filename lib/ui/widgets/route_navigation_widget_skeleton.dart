import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class RouteNavigationWidgetSkeleton extends StatelessWidget {
  const RouteNavigationWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      height: 240.h,
      child: Row(children: [
        SkeletonLine(
          style: SkeletonLineStyle(
              width: 220.w,
              height: 240.h,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
        SizedBox(
          width: 20.w,
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              width: 612.w,
              height: 240.h,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
        SizedBox(
          width: 20.w,
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              width: 150.w,
              height: 240.h,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
      ]),
    );
  }
}
