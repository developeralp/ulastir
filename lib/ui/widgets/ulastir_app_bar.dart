import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UlastirAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UlastirAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.staatliches(fontSize: 72.sp),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
