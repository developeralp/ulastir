import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonAutoComplete extends StatelessWidget {
  const SkeletonAutoComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLine(
      style: SkeletonLineStyle(
          height: 162.h,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}
