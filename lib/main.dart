import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.mode,
      home: const _ThemeTestScreen(),
    );
  }
}

class _ThemeTestScreen extends StatelessWidget {
  const _ThemeTestScreen();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Test theme')),
      body: Center(
        child: SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(value: ThemeMode.light, label: Text('Sáng')),
            ButtonSegment(value: ThemeMode.dark, label: Text('Tối')),
            ButtonSegment(value: ThemeMode.system, label: Text('Hệ thống')),
          ],
          selected: {themeProvider.mode},
          onSelectionChanged: (s) => themeProvider.setMode(s.first),
        ),
      ),
    );
  }
}