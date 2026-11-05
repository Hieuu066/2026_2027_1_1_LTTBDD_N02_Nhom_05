import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../utils/stats_helper.dart';

// Hai nhận xét đơn giản của tháng: ngày vui nhất và lý do nhiều nhất
class StatsInsights extends StatelessWidget {
  final List<MoodEntry> entries;

  const StatsInsights({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final happiest = StatsHelper.happiestEntry(entries);
    final top = StatsHelper.topReason(entries);

    return Card(
      child: Column(
        children: [
          // Ngày vui nhất
          if (happiest != null)
            ListTile(
              leading: Text(
                happiest.mood.emoji,
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(t.statsHappiestDay),
              subtitle: Text(
                '${DateFormat.yMMMd(locale).format(happiest.date)}'
                ' · ${happiest.mood.label(t)} (${happiest.level}/10)',
              ),
            ),
          // Lý do xuất hiện nhiều nhất
          ListTile(
            leading: Icon(top == null ? Icons.help_outline : top.key.icon),
            title: Text(t.statsTopReason),
            subtitle: Text(
              top == null
                  ? t.statsNoReason
                  : '${top.key.label(t)} · ${t.statsTimes(top.value)}',
            ),
          ),
        ],
      ),
    );
  }
}