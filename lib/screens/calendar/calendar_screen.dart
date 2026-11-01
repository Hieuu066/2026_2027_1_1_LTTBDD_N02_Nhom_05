import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_entry_tile.dart'; // <-- 9a

import '../entry/entry_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now(); // tháng đang hiển thị
  DateTime _selectedDay = DateTime.now(); // ngày đang được chọn

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    // 'vi' hoặc 'en' theo ngôn ngữ đang chọn
    final locale = Localizations.localeOf(context).toString();
    // watch: khi nhật ký thay đổi thì lịch tự cập nhật
    final mood = context.watch<MoodProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(t.calendarTitle)),
      body: Column(
        children: [
          TableCalendar<MoodEntry>(
            locale: locale,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            // Mỗi ngày lấy danh sách nhật ký từ MoodProvider của Hiệu
            eventLoader: (day) => mood.getEntriesOfDay(day),
            calendarBuilders: CalendarBuilders<MoodEntry>(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return null;
                return Positioned(
                  bottom: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tối đa 3 chấm, mỗi chấm màu theo cảm xúc
                      for (final e in events.take(3))
                        Container(
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: e.mood.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // ===== 9b: thêm 2 dòng này =====
          const Divider(height: 1),
          Expanded(child: _buildSelectedDay(t, mood)),
        ],
      ),
    );
  }

  // ===== 9c: thêm hàm này =====
  // Danh sách nhật ký của ngày đang chọn
  Widget _buildSelectedDay(AppLocalizations t, MoodProvider mood) {
    final entries = mood.getEntriesOfDay(_selectedDay);
    if (entries.isEmpty) {
      return Center(child: Text(t.calendarNoEntry));
    }
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (final e in entries)
          MoodEntryTile(
            entry: e,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EntryDetailScreen(entry: e)),
            ),
          ),
      ],
    );
  }
}