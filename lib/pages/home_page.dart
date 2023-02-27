import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulastir/pages/tabs/saved_routes_tab.dart';
import 'package:ulastir/pages/tabs/welcome_tab.dart';

final indexProvider = StateProvider<int>(
  (ref) => 0,
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Widget> fragments = const [
    WelcomeTab(),
    SavedRoutesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final int index = ref.watch(indexProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        elevation: 4,
        items: const [
          BottomNavigationBarItem(
              label: 'Ana Sayfa', icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(
              label: 'Yolculuklar', icon: Icon(Icons.directions)),
        ],
        onTap: (value) {
          ref.read(indexProvider.notifier).update((state) => value);
        },
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ULAŞTIR!',
          style: GoogleFonts.staatliches(fontSize: 78.sp),
        ),
      ),
      body: fragments[index],
    );
  }
}
