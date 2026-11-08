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

  // Ô ngày: có nhật ký thì tô nền theo màu cảm xúc
  Widget _dayCell(
    DateTime day,
    MoodProvider mood,
    ColorScheme scheme, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    final entries = mood.getEntriesOfDay(day);

    // Màu nền: cảm xúc của nhật ký mới nhất trong ngày
    Color? fill;
    if (entries.isNotEmpty) {
      final latest = entries.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
      fill = latest.mood.color;
    }
    // Ngày được chọn mà chưa có nhật ký thì tô màu chủ đạo
    if (fill == null && isSelected) fill = scheme.primary;

    // Nền đậm thì chữ trắng, nền nhạt thì chữ đen
    Color textColor;
    if (fill != null) {
      textColor = ThemeData.estimateBrightnessForColor(fill) == Brightness.dark
          ? Colors.white
          : Colors.black87;
    } else {
      textColor = day.weekday >= DateTime.saturday
          ? scheme.error
          : scheme.onSurface;
    }

    // Viền: ngày được chọn dày, hôm nay mỏng
    Border? border;
    if (isSelected) {
      border = Border.all(color: scheme.primary, width: 3);
    } else if (isToday) {
      border = Border.all(color: scheme.primary, width: 2);
    }

    return Container(
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: border,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: (isToday || isSelected || entries.isNotEmpty)
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toString();
    final mood = context.watch<MoodProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(t.calendarTitle)),
      body: Column(
        children: [
          // Thẻ lịch: viền mảnh, bóng đổ nhẹ
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 6,
            shadowColor: scheme.primary.withValues(alpha: 0.25),
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: scheme.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
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
                // Thanh tháng tông nhạt
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(color: scheme.primaryContainer),
                  titleTextStyle: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimaryContainer,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: scheme.onPrimaryContainer,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                // Tự vẽ ô ngày để tô nền theo cảm xúc
                calendarBuilders: CalendarBuilders<MoodEntry>(
                  defaultBuilder: (context, day, focusedDay) =>
                      _dayCell(day, mood, scheme),
                  todayBuilder: (context, day, focusedDay) =>
                      _dayCell(day, mood, scheme, isToday: true),
                  selectedBuilder: (context, day, focusedDay) => _dayCell(
                    day,
                    mood,
                    scheme,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: true,
                  ),
                ),
              ),
            ),
          ),

          // Phần nhật ký của ngày đang chọn
          Expanded(child: _buildHistoryPanel(t, scheme, textTheme, locale, mood)),
        ],
      ),
    );
  }

  // Khung nhật ký của ngày đang chọn, cùng kiểu với thẻ lịch
  Widget _buildHistoryPanel(
    AppLocalizations t,
    ColorScheme scheme,
    TextTheme textTheme,
    String locale,
    MoodProvider mood,
  ) {
    final entries = mood.getEntriesOfDay(_selectedDay);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Thanh tiêu đề: ngày đang chọn và số nhật ký
          Container(
            width: double.infinity,
            color: scheme.primaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.event_note, color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormat.yMMMMd(locale).format(_selectedDay),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${entries.length}',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_note, size: 48, color: scheme.outline),
                        const SizedBox(height: 8),
                        Text(t.calendarNoEntry),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(12),
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
      ),
    );
  }
}