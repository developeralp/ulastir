import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class HowToUseWidget extends StatelessWidget {
  const HowToUseWidget({super.key, required this.updateProvider});

  final Function updateProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Designer.outlinedContainer,
      padding: EdgeInsets.all(24.w),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: Designer.outlinedContainer,
                  child: InkWell(
                      onTap: () => dontShowAgain(),
                      child: Row(
                        children: [
                          Text(Localizer.i.text('do_not_show_again')),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 56.w,
                          )
                        ],
                      )))),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Icon(
                  Icons.live_help,
                  size: 64.w,
                  color: Colors.blue[900],
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  Localizer.i.text('how_to_use'),
                  style: TextStyle(fontSize: 54.sp),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(Localizer.i.text('how_to_use_1')),
            Text(Localizer.i.text('how_to_use_2')),
            Text(Localizer.i.text('how_to_use_3')),
            SizedBox(
              height: 10.h,
            ),
            Text(Localizer.i.text('how_to_use_warning')),
          ]),
        ],
      ),
    );
  }

  void dontShowAgain() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('show_how_to_use', false);
    updateProvider();
  }
}
