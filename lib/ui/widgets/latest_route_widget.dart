import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestRouteWidget extends StatelessWidget {
  const LatestRouteWidget({super.key, required this.name, required this.open});

  final String name;
  final Function open;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => open(),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Icon(
                  Icons.directions,
                  color: Colors.orange[800],
                  size: 84.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SON YOLCULUK',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 56.sp),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 52.sp),
                    )
                  ],
                )
              ],
            )));
  }
}
