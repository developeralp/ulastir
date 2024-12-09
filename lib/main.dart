import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ulastir/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocalStorage();

  runApp(const ProviderScope(child: UlastirApp()));
}
