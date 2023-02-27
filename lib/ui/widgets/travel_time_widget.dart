import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/designer.dart';

class TravelTimeWidget extends StatelessWidget {
  const TravelTimeWidget(
      {super.key, required this.time, required this.addTopMargin});

  final int time;
  final bool addTopMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32.h, top: (addTopMargin ? 32.h : 0)),
      decoration: Designer.outlinedContainer,
      padding: EdgeInsets.all(20.w),
      child: Row(children: [
        const Expanded(
          flex: 1,
          child: Icon(Icons.timer, color: Colors.deepPurple),
        ),
        Expanded(
          flex: 9,
          child: Text('$time DK YOLCULUK SÜRESİ',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }
}
