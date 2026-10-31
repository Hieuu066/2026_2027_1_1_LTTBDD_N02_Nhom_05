import 'package:flutter/material.dart';

// ngôn ngữ đang chọn: tiếng Việt hoặc tiếng Anh
class LocaleProvider extends ChangeNotifier {
  // Mặc định là tiếng Việt
  Locale _locale = const Locale('vi');
  Locale get locale => _locale;

  // Đổi ngôn ngữ
  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}