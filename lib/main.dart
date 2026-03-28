import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const ColorGameApp());
}

class ColorGameApp extends StatelessWidget {
  const ColorGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
