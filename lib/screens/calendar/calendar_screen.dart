import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_entry_tile.dart';
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
    final cs = Theme.of(context).colorScheme;
    // 'vi' hoặc 'en' theo ngôn ngữ đang chọn
    final locale = Localizations.localeOf(context).toString();
    // watch: khi nhật ký thay đổi thì lịch tự cập nhật
    final mood = context.watch<MoodProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(t.calendarTitle), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: cs.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TableCalendar<MoodEntry>(
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
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                    leftChevronIcon:
                        Icon(Icons.chevron_left_rounded, color: cs.primary),
                    rightChevronIcon:
                        Icon(Icons.chevron_right_rounded, color: cs.primary),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Mỗi ngày lấy danh sách nhật ký từ MoodProvider của Hiệu
                  eventLoader: (day) => mood.getEntriesOfDay(day),
                  calendarBuilders: CalendarBuilders<MoodEntry>(
                    markerBuilder: (context, day, events) {
                      if (events.isEmpty) return null;
                      return Positioned(
                        bottom: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Tối đa 3 chấm, mỗi chấm màu theo cảm xúc
                            for (final e in events.take(3))
                              Container(
                                width: 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  color: e.mood.color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: cs.surface,
                                    width: 1,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: _buildSelectedDay(t, mood, locale)),
        ],
      ),
    );
  }

  // Phần bên dưới lịch: ngày đang chọn và danh sách nhật ký của ngày đó
  Widget _buildSelectedDay(
    AppLocalizations t,
    MoodProvider mood,
    String locale,
  ) {
    final cs = Theme.of(context).colorScheme;
    final entries = mood.getEntriesOfDay(_selectedDay);
    final dateText = DateFormat.yMMMMEEEEd(locale).format(_selectedDay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            dateText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: entries.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.event_note_outlined,
                        size: 48,
                        color: cs.outline,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.calendarNoEntry,
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  children: [
                    for (final e in entries)
                      MoodEntryTile(
                        entry: e,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EntryDetailScreen(entry: e),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}