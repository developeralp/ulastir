import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/models/station_result.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/misc/slack.dart';
import 'package:ulastir/ui/widgets/custom_expansion_tile.dart';
import 'package:ulastir/utils/localizer.dart';

class RouteNavigationGridWidget extends StatelessWidget {
  const RouteNavigationGridWidget(
      {super.key, required this.result, required this.index});

  final StationResult result;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        //  margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Designer.borderRadius),
          ),

          color: Designer.darkMode
              ? Colors.grey[800]
              : Colors.grey[300], //(widget.color ?? Colors.black87),
        ),
        child: RouteNavigationExpansionTile(
          stationResult: result,
          titleColor: result.active ? Colors.indigo[600]! : Colors.grey[700]!,
          title: Text(result.routeObj?.lineName ?? ''),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StationNameWidget(
                        active: result.active,
                        name: result.routeObj?.stationName ?? ''),
                    const Slack(),
                    if (!result.active)
                      Center(
                        child: Text(
                          'Maalesef bu hatta kalkış yok...'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 50.sp),
                        ),
                      ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        var element = result.list[index];

                        return StationTimeWidget(
                          time: element.time,
                          station: result.routeObj?.stationName ?? '',
                          last: index == result.list.length - 1,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20.w,
                        crossAxisSpacing: 20.h,
                      ),
                    ),
                    const Slack(),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class LineTitleWidget extends StatelessWidget {
  const LineTitleWidget(
      {super.key,
      required this.line,
      required this.title,
      required this.color,
      required this.active,
      required this.onTap,
      required this.expanded});

  final bool expanded;
  final String title;
  final Color? color;
  final Lines? line;
  final bool active;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Timer(const Duration(milliseconds: 50), () {
            onTap();
          });
        },
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            borderRadius: expanded
                ? BorderRadius.vertical(
                    top: Radius.circular(Designer.borderRadius),
                  )
                : BorderRadius.all(Radius.circular(Designer.borderRadius)),

            color: color, //(widget.color ?? Colors.black87),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                line == Lines.bus
                    ? Icons.directions_bus_filled_sharp
                    : Icons.directions_train,
                color: Colors.white,
                size: 78.w,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 72.sp,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white),
            ],
          ),
        ));
  }
}

class StationNameWidget extends StatelessWidget {
  const StationNameWidget(
      {super.key, required this.name, required this.active});

  final String name;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          color: active ? Colors.orange[900] : Colors.grey[800],
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Designer.borderRadius),
          )),
      child: Row(
        children: [
          Icon(
            Icons.hail,
            size: 92.w,
            color: Colors.white,
          ),
          Expanded(
              child: Text(name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 54.sp,
                      color: Colors.white))),
        ],
      ),
    );
  }
}

class StationTimeWidget extends StatelessWidget {
  const StationTimeWidget(
      {super.key,
      required this.time,
      required this.station,
      required this.last});

  final String time;
  final String station;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: !last ? Colors.grey[900] : Colors.red[900],
        borderRadius: BorderRadius.circular(Designer.borderRadius),
      ),
      child: Center(
        child: Text(
          (last ? '${Localizer.i.text('last')} $time' : time),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 64.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
