import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Designer {
  static double borderRadius = 8;
  static double borderWidth = 1.50;

  static double slackHeight = 40.h;

  static double pagePadding = 32.w;

  static bool darkMode =
      (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark);

  static Color? backgroundColor =
      (darkMode ? Colors.grey[700] : Colors.grey[100]);

  static Color textColor = (darkMode ? Colors.white : Colors.black);
  static Color textColorDefaultPrimary =
      (darkMode ? Colors.white : Colors.deepPurple);

  static ButtonStyle get outlinedButton {
    return OutlinedButton.styleFrom(
      alignment: Alignment.centerLeft,
      backgroundColor: (const Color.fromARGB(255, 82, 34, 165)),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(42.w),
    );
  }

  static ButtonStyle get outlinedButtonOrange {
    return OutlinedButton.styleFrom(
      alignment: Alignment.centerLeft,
      backgroundColor: (Colors.deepOrange[600]),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      padding: EdgeInsets.all(42.w),
    );
  }

  static BoxDecoration get outlinedContainer {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(Designer.borderRadius),
      border: Border.all(color: Colors.grey),
    );
  }

  static InputDecoration outlinedTextField(
      {String? label, required IconData icon}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:
              BorderSide(color: darkMode ? Colors.white : Colors.deepPurple)),
      errorStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(
        icon,
        color: (darkMode ? Colors.white : Colors.deepPurple),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      labelStyle:
          TextStyle(color: (darkMode ? Colors.white : Colors.grey[700])),
      labelText: (label ?? ''),
    );
  }

  static InputDecoration outlinedTextFieldDisabled(
      {String? label, required IconData icon}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: darkMode ? Colors.white : Colors.grey)),
      errorStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(
        icon,
        color: (darkMode ? Colors.white : Colors.grey),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      labelStyle:
          TextStyle(color: (darkMode ? Colors.white : Colors.grey[700])),
      labelText: (label ?? ''),
    );
  }
}
