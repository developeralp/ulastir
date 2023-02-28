import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulastir/ui/designer.dart';

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
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: const Text('Bir daha gösterme'),
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 42.w,
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
                  'Nasıl kullanılır?',
                  style: TextStyle(fontSize: 54.sp),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text('1) Yeni bir yolculuk oluşturun'),
            const Text('2) Binebileceğiniz otobüsleri ekleyin'),
            const Text('3) Yolculuğunuza bir ad verin'),
            SizedBox(
              height: 10.h,
            ),
            const Text(
                'NOT: Bu uygulama size ulaşım önerileri sunmaz, pratik bir şekilde sürekli kullandığınız otobüslerin durak vakitlerini hızlıca görmenizi sağlar'),
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
