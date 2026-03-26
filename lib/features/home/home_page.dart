import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulastir/features/home/tabs/saved_routes_tab.dart';
import 'package:ulastir/features/home/tabs/welcome_tab.dart';
import 'package:ulastir/app/theme/designer.dart';
import 'package:ulastir/common/ui/widgets/ulastir_app_bar.dart';
import 'package:ulastir/app/helpers/localizer.dart';

class IndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

final indexProvider = NotifierProvider<IndexNotifier, int>(
  IndexNotifier.new,
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
      backgroundColor: Designer.backgroundColor,
      appBar: const UlastirAppBar(title: 'ULAŞTIR!'),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        elevation: 4,
        items: [
          BottomNavigationBarItem(
              label: Localizer.i.text('tabs_home_page').toUpperCase(),
              icon: const Icon(Icons.home_rounded)),
          BottomNavigationBarItem(
              label: Localizer.i.text('tabs_routes').toUpperCase(),
              icon: const Icon(Icons.directions)),
        ],
        onTap: (value) {
          ref.read(indexProvider.notifier).update(value);
        },
      ),
      body: SafeArea(child: fragments[index]),
    );
  }
}
