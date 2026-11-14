import 'dart:typed_data';

import 'mood_reason.dart';
import 'mood_type.dart';

// Một mục nhật ký
class MoodEntry {
  String id; // mã riêng của nhật ký, không trùng nhau
  DateTime date; // ngày giờ ghi
  MoodType mood; // cảm xúc
  int level; // mức độ từ 1 đến 10
  List<MoodReason> reasons; // các lý do đã chọn
  String note; // ghi chú
  Uint8List? image; // ảnh của ngày dạng dãy byte (có thể không có)

  MoodEntry({
    required this.id,
    required this.date,
    required this.mood,
    required this.level,
    required this.reasons,
    required this.note,
    this.image,
  });

  // Kiểm tra nhật ký này có phải của ngày [day] không
  bool isOnDay(DateTime day) {
    return date.year == day.year &&
        date.month == day.month &&
        date.day == day.day;
  }
}
