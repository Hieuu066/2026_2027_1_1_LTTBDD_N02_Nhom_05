import 'package:flutter/material.dart';
import '../../screens/main_shell.dart';

/// Danh sách "địa chỉ" các màn hình của app.
class AppRoutes {
  AppRoutes._();

  static const String main = '/';

  static const int tabHome = 0;
  static const int tabCalendar = 1;
  static const int tabStats = 2;
  static const int tabSettings = 3;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
      default:
        final tab = settings.arguments is int ? settings.arguments as int : 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainShell(initialIndex: tab),
        );
    }
  }
}