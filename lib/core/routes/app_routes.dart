import 'package:flutter/material.dart';
import '../../screens/about/about_screen.dart';
import '../../screens/main_shell.dart';
import '../../screens/splash/onboarding_screen.dart';
import '../../screens/splash/splash_screen.dart';

/// Danh sách "địa chỉ" các màn hình của app
class AppRoutes {
  AppRoutes._();

  // Splash là màn đầu tiên
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String main = '/main';
  static const String about = '/about';

  static const int tabHome = 0;
  static const int tabCalendar = 1;
  static const int tabStats = 2;
  static const int tabSettings = 3;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case onboarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const OnboardingScreen(),
        );
      case about:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AboutScreen(),
        );
      case main:
      default:
        // arguments
        final tab = settings.arguments is int ? settings.arguments as int : 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainShell(initialIndex: tab),
        );
    }
  }
}