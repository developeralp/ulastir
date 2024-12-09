import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/saved_route.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/ui/misc/slack.dart';

class RouteDesignWidget extends StatefulWidget {
  const RouteDesignWidget({
    super.key,
    required this.lines,
    required this.askDeleteRoute,
  });

  final List<Line> lines;
  final Function(String routeID) askDeleteRoute;

  @override
  State<StatefulWidget> createState() => _RouteDesignWidgetState();
}

class _RouteDesignWidgetState extends State<RouteDesignWidget> {
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

    for (Line routeObj in widget.lines) {
      if (routeObj.type == Lines.bus || routeObj.type == Lines.rail) {
        list.add(transportationStep(routeObj));
      }
    }

    return list;
  }

  Step transportationStep(Line routeObj) {
    return Step(
        title: Row(
          children: [
            Expanded(
                flex: 8,
                child: Text(
                  routeObj.lineName ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 52.sp,
                      color: Designer.textColor),
                )),
            SizedBox(width: 10.w),
            Icon(
              (routeObj.type == Lines.bus
                  ? Icons.directions_bus
                  : Icons.directions_train),
              color: (Designer.darkMode ? Colors.white : Colors.deepPurple),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                widget.askDeleteRoute(routeObj.id);
              },
              child: Icon(
                Icons.delete,
                color: (Designer.darkMode ? Colors.red[400] : Colors.red[700]),
              ),
            ),
          ],
        ),
        content: Container(),
        isActive: true);
  }
}
