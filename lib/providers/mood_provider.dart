import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import '../models/mood_reason.dart';
import '../models/mood_type.dart';

class MoodProvider extends ChangeNotifier {
  // Danh sách nhật ký (lưu tạm trong biến, tắt app sẽ mất)
  final List<MoodEntry> entries = [];

  // Khi tạo provider thì thêm sẵn vài nhật ký mẫu để thử giao diện
  MoodProvider() {
    _addSampleData();
  }

  // Thêm nhật ký mới
  void addEntry(MoodEntry entry) {
    entries.add(entry);
    _sortNewestFirst();
    notifyListeners();
  }

  // Sửa nhật ký (dữ liệu đã được đổi trực tiếp trên entry)
  void updateEntry(MoodEntry entry) {
    _sortNewestFirst();
    notifyListeners();
  }

  // Xóa nhật ký
  void deleteEntry(MoodEntry entry) {
    entries.remove(entry);
    notifyListeners();
  }

  // Lấy 5 nhật ký mới nhất cho Trang chủ
  List<MoodEntry> getRecentEntries() {
    return entries.take(5).toList();
  }

  // Lấy các nhật ký của một ngày (màn Lịch của Khang có thể dùng)
  List<MoodEntry> getEntriesOfDay(DateTime day) {
    List<MoodEntry> result = [];
    for (MoodEntry entry in entries) {
      if (entry.isOnDay(day)) {
        result.add(entry);
      }
    }
    return result;
  }

  // Tìm kiếm theo ghi chú và lọc theo cảm xúc.
  // mood = null nghĩa là không lọc, lấy tất cả cảm xúc.
  List<MoodEntry> search(String keyword, MoodType? mood) {
    List<MoodEntry> result = [];
    for (MoodEntry entry in entries) {
      bool matchMood = mood == null || entry.mood == mood;
      bool matchText = entry.note.toLowerCase().contains(keyword.toLowerCase());
      if (matchMood && matchText) {
        result.add(entry);
      }
    }
    return result;
  }

  // Tạo mã mới cho nhật ký dựa vào thời gian hiện tại
  String createId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Sắp xếp: nhật ký mới nhất lên đầu
  void _sortNewestFirst() {
    entries.sort((a, b) => b.date.compareTo(a.date));
  }

  // Dữ liệu mẫu
  void _addSampleData() {
    DateTime now = DateTime.now();

    entries.add(
      MoodEntry(
        id: '1',
        date: now.subtract(const Duration(days: 1)),
        mood: MoodType.happy,
        level: 7,
        reasons: [MoodReason.friends],
        note: 'Đi cà phê với nhóm bạn, nói chuyện rất vui.',
      ),
    );
    entries.add(
      MoodEntry(
        id: '2',
        date: now.subtract(const Duration(days: 2)),
        mood: MoodType.neutral,
        level: 5,
        reasons: [MoodReason.study],
        note: 'Học bài cả ngày, hơi mệt nhưng ổn.',
      ),
    );
    entries.add(
      MoodEntry(
        id: '3',
        date: now.subtract(const Duration(days: 3)),
        mood: MoodType.sad,
        level: 6,
        reasons: [MoodReason.study],
        note: 'Bài kiểm tra không tốt như mong đợi.',
      ),
    );
    entries.add(
      MoodEntry(
        id: '4',
        date: now.subtract(const Duration(days: 5)),
        mood: MoodType.veryHappy,
        level: 9,
        reasons: [MoodReason.family],
        note: 'Cả nhà ăn tối cùng nhau, mẹ nấu món mình thích.',
      ),
    );
    entries.add(
      MoodEntry(
        id: '5',
        date: now.subtract(const Duration(days: 7)),
        mood: MoodType.verySad,
        level: 8,
        reasons: [MoodReason.work],
        note: 'Làm thêm bị trách vì đến muộn.',
      ),
    );
    entries.add(
      MoodEntry(
        id: '6',
        date: now.subtract(const Duration(days: 10)),
        mood: MoodType.happy,
        level: 8,
        reasons: [MoodReason.health, MoodReason.friends],
        note: 'Chạy bộ buổi sáng với bạn, thấy khỏe hơn.',
      ),
    );

    _sortNewestFirst();
  }
}
