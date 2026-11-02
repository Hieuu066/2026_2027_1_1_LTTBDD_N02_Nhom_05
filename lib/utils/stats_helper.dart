import '../models/mood_entry.dart';
import '../models/mood_type.dart';

// Các hàm tính số liệu cho màn Thống kê
class StatsHelper {
  StatsHelper._();

  // Lấy các nhật ký thuộc tháng [month]
  static List<MoodEntry> entriesOfMonth(List<MoodEntry> all, DateTime month) {
    return all
        .where((e) => e.date.year == month.year && e.date.month == month.month)
        .toList();
  }

  // Đếm số nhật ký của từng loại cảm xúc
  static Map<MoodType, int> countByMood(List<MoodEntry> entries) {
    final result = {for (final m in MoodType.values) m: 0};
    for (final e in entries) {
      result[e.mood] = result[e.mood]! + 1;
    }
    return result;
  }

  // Điểm của cảm xúc: rất vui = 5 ... rất buồn = 1
  static int moodScore(MoodType mood) => 5 - mood.index;

  // Điểm trung bình theo từng tuần của tháng.
  // Tuần 1 là ngày 1-7, tuần 2 là ngày 8-14, ... Tuần không có dữ liệu = 0.
  static List<double> weeklyAverage(List<MoodEntry> monthEntries, DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final weekCount = ((daysInMonth - 1) ~/ 7) + 1;
    final sums = List<double>.filled(weekCount, 0);
    final counts = List<int>.filled(weekCount, 0);

    for (final e in monthEntries) {
      final week = (e.date.day - 1) ~/ 7;
      sums[week] += moodScore(e.mood);
      counts[week]++;
    }
    return [
      for (var i = 0; i < weekCount; i++)
        counts[i] == 0 ? 0.0 : sums[i] / counts[i],
    ];
  }
}