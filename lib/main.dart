import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/theme/default_theme.dart';
import 'package:template/di.dart';
import 'package:template/features/home/my_home_page.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialBinding: DI(),
    );
  }
}
