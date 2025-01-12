import 'package:flutter/material.dart';
import 'package:koselie/core/common/app_theme/app_theme.dart';
import 'package:koselie/view/splash_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'Koselie',
      theme: getApplicationTheme(),
      home: SplashScreen(), // Set the initial screen to SplashScreen
    );
  }
}
