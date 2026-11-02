import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../models/mood_type.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_entry_tile.dart';
import '../../widgets/mood_picker.dart';
import '../entry/entry_detail_screen.dart';
import '../entry/entry_form_screen.dart';

// Màn Trang chủ: lời chào, chọn cảm xúc nhanh, nhật ký gần đây
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Chọn lời chào theo giờ hiện tại
  String _getGreeting(AppLocalizations t) {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return t.homeGreetingMorning;
    } else if (hour < 18) {
      return t.homeGreetingAfternoon;
    } else {
      return t.homeGreetingEvening;
    }
  }

  // Mở màn Chi tiết nhật ký (màn của Khang)
  void _openDetail(BuildContext context, MoodEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryDetailScreen(entry: entry)),
    );
  }

  // Mở màn Thêm nhật ký, có thể chọn sẵn một cảm xúc
  void _openAddForm(BuildContext context, MoodType? mood) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryFormScreen(initialMood: mood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final moodProvider = context.watch<MoodProvider>();

    // Hôm nay đã ghi nhật ký chưa
    bool wroteToday = moodProvider.getEntriesOfDay(DateTime.now()).isNotEmpty;

    // 5 nhật ký mới nhất
    List<MoodEntry> recentEntries = moodProvider.getRecentEntries();

    return Scaffold(
      appBar: AppBar(title: Text(t.appTitle)),

      // Nút tròn góc dưới bên phải để thêm nhật ký
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddForm(context, null),
        icon: const Icon(Icons.add),
        label: Text(t.entryAddTitle),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Lời chào
          Text(
            _getGreeting(t),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),

          // Câu hỏi, hoặc lời nhắc nếu hôm nay đã ghi rồi
          Text(
            wroteToday ? t.homeTodayDone : t.homeQuestion,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Chọn cảm xúc nhanh: chạm vào là mở màn Thêm với cảm xúc đó
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: MoodPicker(
                selectedMood: null,
                onSelect: (mood) => _openAddForm(context, mood),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tiêu đề phần nhật ký gần đây
          Text(
            t.homeRecentTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Chưa có nhật ký nào thì hiện lời nhắc
          if (recentEntries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(t.homeEmpty, textAlign: TextAlign.center),
            )
          // Có nhật ký thì hiện từng thẻ
          else
            for (MoodEntry entry in recentEntries)
              MoodEntryTile(
                entry: entry,
                onTap: () => _openDetail(context, entry),
              ),

          // Chừa chỗ để nút Thêm không che thẻ cuối cùng
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
