import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class LastRouteWidget extends StatelessWidget {
  const LastRouteWidget({super.key, required this.name, required this.open});

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
                  Icons.directions_outlined,
                  color: Colors.orange[800],
                  size: 128.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localizer.i.text('last_route'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 42.sp,
                          color: Designer.textColor),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 52.sp,
                          color: Designer.textColor),
                    )
                  ],
                )
              ],
            )));
  }
}
