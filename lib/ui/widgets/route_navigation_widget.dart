import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/station_result.dart';
import 'package:ulastir/ui/designer.dart';

class RouteNavigationWidget extends ConsumerWidget {
  const RouteNavigationWidget({super.key, required this.result});

  final StationResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 24.h),
        height: 240.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: result.list.length,
            itemBuilder: (context, index) {
              var element = result.list[index];

              if (element is StationVehicleItem) {
                return RouteHeaderWidget(
                    title: result.routeObj?.lineNameShort ?? '',
                    color: Colors.indigo[600]);
              } else if (element is StationOrItem) {
                return const RouteOrWidget();
              }

              return Container();
            }));
  }
}

class RouteHeaderWidget extends StatelessWidget {
  const RouteHeaderWidget(
      {super.key, required this.title, required this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Designer.borderRadius),
        color: color, //(widget.color ?? Colors.black87),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.directions_bus_filled_sharp,
            color: Colors.white,
            size: 84.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 88.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class RouteOrWidget extends StatelessWidget {
  const RouteOrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Designer.borderRadius),
          color: Colors.orange[800],
        ),
        child: Center(
          child: Text(
            'YA DA',
            style: TextStyle(
                color: Colors.white,
                fontSize: 64.sp,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
