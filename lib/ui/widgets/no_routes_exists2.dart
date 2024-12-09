import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class NoRouteExists2Widget extends StatelessWidget {
  const NoRouteExists2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: Designer.outlinedContainer,
      child: Column(
        children: [
          Text(Localizer.i.text('no_route_exists_yet'),
              style: TextStyle(
                fontSize: 56.sp,
                fontWeight: FontWeight.w300,
              )),
        ],
      ),
    );
  }
}
