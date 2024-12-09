import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/models/enums/lines.dart';
import 'package:ulastir/ui/designer.dart';

class RouteWidget extends StatelessWidget {
  final Lines routeType;
  final String line;
  final String station;
  final Function onAskDelete;
  final bool addTopMargin;

  const RouteWidget({
    super.key,
    required this.routeType,
    required this.line,
    required this.station,
    required this.onAskDelete,
    required this.addTopMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 32.h, top: (addTopMargin ? 32.h : 0)),
        decoration: Designer.outlinedContainer,
        child: InkWell(
          onTap: () {},
          child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  (routeType == Lines.bus
                                      ? Icons.directions_bus
                                      : Icons.directions_train),
                                  color: Colors.deepPurple,
                                  size: 62.w,
                                )),
                            Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        line,
                                        style: TextStyle(
                                            fontSize: 56.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Designer.textColor),
                                      ),
                                      Text(
                                        station,
                                        style: TextStyle(
                                          fontSize: 48.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => onAskDelete(),
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red[800],
                          size: 62.w,
                        ),
                      ),
                    )
                  ])),
        ));
  }
}
