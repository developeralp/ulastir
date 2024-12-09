import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulastir/ui/designer.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
      this.color,
      required this.icon,
      required this.title,
      required this.onClicked});

  final IconData icon;
  final String title;
  final Function onClicked;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 172.h,
        child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(36.w),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Designer.borderRadius),
              ),
              side: BorderSide(
                  width: 1,
                  color: (color == null
                      ? (Designer.darkMode ? Colors.white : Colors.deepPurple)
                      : color!)),
            ),
            icon: Icon(
              icon,
              color: (color ??
                  (Designer.darkMode ? Colors.white : Colors.deepPurple)),
            ),
            onPressed: () {
              onClicked();
            },
            label: Text(
              title,
              style: TextStyle(color: Designer.textColor),
            )));
  }
}
