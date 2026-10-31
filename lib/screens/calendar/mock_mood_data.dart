import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

// DỮ LIỆU GIẢ của B để thử giao diện.
// Khi A xong MoodProvider thì thay bằng dữ liệu thật rồi xóa file này.
enum MockMood { veryHappy, happy, neutral, sad, verySad }

extension MockMoodX on MockMood {
  Color get color {
    switch (this) {
      case MockMood.veryHappy:
        return AppColors.moodVeryHappy;
      case MockMood.happy:
        return AppColors.moodHappy;
      case MockMood.neutral:
        return AppColors.moodNeutral;
      case MockMood.sad:
        return AppColors.moodSad;
      case MockMood.verySad:
        return AppColors.moodVerySad;
    }
  }

  String get emoji {
    switch (this) {
      case MockMood.veryHappy:
        return '😄';
      case MockMood.happy:
        return '🙂';
      case MockMood.neutral:
        return '😐';
      case MockMood.sad:
        return '😢';
      case MockMood.verySad:
        return '😡';
    }
  }
}

class MockEntry {
  final DateTime date;
  final MockMood mood;
  final String note;

  const MockEntry({
    required this.date,
    required this.mood,
    required this.note,
  });
}

/// Tạo 20 nhật ký mẫu cho 20 ngày gần nhất.
List<MockEntry> buildMockEntries() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  const moods = MockMood.values;
  return List.generate(20, (i) {
    final date = today.subtract(Duration(days: i));
    return MockEntry(
      date: date,
      mood: moods[(i * 3) % moods.length],
      note: 'Ghi chú mẫu ngày ${date.day}/${date.month}',
    );
  });
}