import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'global/controllers/app.dart';
import 'global/controllers/auth.dart';
import 'global/themes/app_theme.dart';
import 'lang.dart';
import 'modules/start/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  AppBinding().dependencies();
  AuthBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en', ''),
      title: 'Al Majal Pharma',
      theme: appTheme(),
      home: const StartScreen(),
    );
  }
}
