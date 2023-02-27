import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/enums/route_obj_types.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/misc/slack.dart';

class RouteDesignWidget extends ConsumerStatefulWidget {
  const RouteDesignWidget({
    super.key,
    required this.routes,
    required this.askDeleteRoute,
  });

  final List<RouteObj> routes;
  final Function(String routeID) askDeleteRoute;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteDesignWidgetState();
}

class _RouteDesignWidgetState extends ConsumerState<RouteDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Slack(),
        Container(
          decoration: Designer.outlinedContainer,
          child: Stepper(
            key: Key(Random.secure().nextDouble().toString()),
            margin: EdgeInsets.zero,
            controlsBuilder: (context, details) => Container(),
            currentStep: 0,
            steps: steps(),
          ),
        ),
        const Slack(),
      ],
    );
  }

  List<Step> steps() {
    List<Step> list = [];

    for (RouteObj routeObj in widget.routes) {
      if (routeObj.type == RouteObjTypes.bus) {
        list.add(busStep(routeObj));
      }
    }

    return list;
  }

  Step busStep(RouteObj routeObj) {
    return Step(
        title: Row(
          children: [
            Expanded(
                flex: 8,
                child: Text(
                  routeObj.lineName ?? '',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 52.sp),
                )),
            SizedBox(width: 10.w),
            const Icon(
              Icons.directions_bus,
              color: Colors.deepPurple,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                widget.askDeleteRoute(routeObj.id);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red[700],
              ),
            ),
          ],
        ),
        content: Container(),
        isActive: true);
  }

  Step travelTimeStep(RouteObj routeObj) {
    return Step(
        title: Row(
          children: [
            Text(
              '${routeObj.travelTime} DK YOLCULUK SÜRESİ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 50.sp,
                  fontStyle: FontStyle.italic),
            ),
            const Spacer(),
            Icon(
              Icons.delete,
              color: Colors.red[800],
            ),
          ],
        ),
        content: Container(),
        isActive: true);
  }
}
