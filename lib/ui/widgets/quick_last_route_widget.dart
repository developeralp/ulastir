import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/models/station_result.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class QuickLastRouteWidget extends ConsumerWidget {
  const QuickLastRouteWidget(
      {super.key, required this.result, required this.open});

  final StationResult result;
  final Function open;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 24.h),
        height: 240.h,
        child: InkWell(
            onTap: () {
              open();
            },
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: result.list.length,
                itemBuilder: (context, index) {
                  var element = result.list[index];

                  if (element is StationVehicleItem) {
                    return RouteHeaderWidget(
                        line: result.routeObj?.type,
                        title: result.routeObj?.lineNameShort ?? '',
                        color: Colors.indigo[600]);
                  } else if (element is StationOrItem) {
                    return const RouteOrWidget();
                  } else if (element is StationTime) {
                    return StationTimeWidget(
                      time: element.time,
                      station: result.routeObj?.stationName ?? '',
                    );
                  }

                  return Container();
                })));
  }
}

class RouteHeaderWidget extends StatelessWidget {
  const RouteHeaderWidget(
      {super.key,
      required this.line,
      required this.title,
      required this.color});

  final String title;
  final Color? color;
  final Lines? line;

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
            line == Lines.bus
                ? Icons.directions_bus_filled_sharp
                : Icons.directions_train,
            color: Colors.white,
            size: 84.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          if (title.length <= 2)
            Text(
              (title),
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

class StationTimeWidget extends StatelessWidget {
  const StationTimeWidget(
      {super.key, required this.time, required this.station});

  final String time;
  final String station;

  /*  Expanded(
            child: Text(
              station,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 62.sp,
                  fontWeight: FontWeight.w200),
            ),
          )*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(Designer.borderRadius),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
              color: Colors.white,
              fontSize: 88.sp,
              fontWeight: FontWeight.bold),
        ),
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
            Localizer.i.text('or'),
            style: TextStyle(
                color: Colors.white,
                fontSize: 64.sp,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
