import 'package:flutter/material.dart';

// bật/tắt và giờ nhắc
class ReminderProvider extends ChangeNotifier {
  // bật nhắc lúc 20:00
  bool _enabled = true;
  TimeOfDay _time = const TimeOfDay(hour: 20, minute: 0);

  bool get enabled => _enabled;
  TimeOfDay get time => _time;

  /// Bật hoặc tắt nhắc nhở.
  void setEnabled(bool value) {
    if (_enabled == value) return; // giá trị không đổi thì bỏ qua
    _enabled = value;
    notifyListeners();
  }

  /// Đổi giờ nhắc.
  void setTime(TimeOfDay value) {
    if (_time == value) return;
    _time = value;
    notifyListeners();
  }
}