import 'package:flutter/material.dart';
import 'package:petplaza/features/initial_page.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialPage(),
      theme: AppThemes.lightTheme,  // Light theme
      darkTheme: AppThemes.darkTheme,  // Dark theme
      themeMode: ThemeMode.system,  // Switches based on system settings (light/dark)
    );
  }
}