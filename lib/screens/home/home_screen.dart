import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/mood_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final moodProvider = context.watch<MoodProvider>();

    // Hôm nay đã ghi nhật ký chưa
    bool wroteToday = moodProvider.getEntriesOfDay(DateTime.now()).isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(t.appTitle)),
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
        ],
      ),
    );
  }
}
