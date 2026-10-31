import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    //nơi đăng ký các provider dùng chung toàn app
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
    // Theo dõi ThemeProvider
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nhật ký cảm xúc',
      theme: AppTheme.light, // giao diện sáng
      darkTheme: AppTheme.dark, // giao diện tối
      themeMode: themeProvider.mode, // chế độ đang chọn
      initialRoute: AppRoutes.main, // màn hình mở đầu tiên
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}