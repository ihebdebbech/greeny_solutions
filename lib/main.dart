import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeny_solution/spash_creen.dart';
import 'package:greeny_solution/theme/default_theme.dart';
import 'package:greeny_solution/di.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: DefaultTheme.themeData,
      home: SplashScreen(),
      initialBinding: DI(),
    );
  }
}
