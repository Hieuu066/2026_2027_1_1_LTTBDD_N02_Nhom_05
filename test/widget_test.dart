import 'package:flutter_test/flutter_test.dart';
import 'package:lttbdd_app/models/mood_entry.dart';
import 'package:lttbdd_app/models/mood_type.dart';
import 'package:lttbdd_app/providers/mood_provider.dart';

// Tạo nhanh một nhật ký để kiểm thử
MoodEntry taoNhatKy(String id, MoodType mood, String note, DateTime date) {
  return MoodEntry(
    id: id,
    date: date,
    mood: mood,
    level: 5,
    reasons: [],
    note: note,
  );
}

void main() {
  test('Có sẵn dữ liệu mẫu khi khởi tạo', () {
    final provider = MoodProvider();
    expect(provider.entries, isNotEmpty);
  });

  test('Thêm nhật ký mới thì nó đứng đầu danh sách', () {
    final provider = MoodProvider();
    final soLuongCu = provider.entries.length;
    provider.addEntry(
      taoNhatKy('t1', MoodType.happy, 'Kiểm thử', DateTime.now()),
    );
    expect(provider.entries.length, soLuongCu + 1);
    expect(provider.entries.first.id, 't1');
  });

  test('Xóa nhật ký', () {
    final provider = MoodProvider();
    final nhatKy = taoNhatKy('t2', MoodType.sad, 'Sẽ bị xóa', DateTime.now());
    provider.addEntry(nhatKy);
    provider.deleteEntry(nhatKy);
    expect(provider.entries.contains(nhatKy), isFalse);
  });

  test('Tìm theo ghi chú và lọc theo cảm xúc', () {
    final provider = MoodProvider();
    provider.addEntry(
      taoNhatKy('t3', MoodType.veryHappy, 'Đi chơi XYZ', DateTime.now()),
    );
    expect(provider.search('xyz', null).map((e) => e.id), contains('t3'));
    expect(provider.search('xyz', MoodType.sad), isEmpty);
  });

  test('Lấy nhật ký theo ngày', () {
    final provider = MoodProvider();
    provider.addEntry(
      taoNhatKy('t4', MoodType.neutral, '', DateTime(2020, 1, 15, 9)),
    );
    expect(
      provider.getEntriesOfDay(DateTime(2020, 1, 15)).map((e) => e.id),
      contains('t4'),
    );
  });
}
