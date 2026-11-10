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
    final cs = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final happiest = StatsHelper.happiestEntry(entries);
    final top = StatsHelper.topReason(entries);

    return Column(
      children: [
        // Ngày vui nhất
        if (happiest != null) ...[
          _InsightTile(
            color: happiest.mood.color,
            leading: Text(
              happiest.mood.emoji,
              style: const TextStyle(fontSize: 26),
            ),
            title: t.statsHappiestDay,
            subtitle: '${DateFormat.yMMMd(locale).format(happiest.date)}'
                ' · ${happiest.mood.label(t)} (${happiest.level}/10)',
          ),
          const SizedBox(height: 10),
        ],
        // Lý do xuất hiện nhiều nhất
        _InsightTile(
          color: cs.primary,
          leading: Icon(
            top == null ? Icons.help_outline : top.key.icon,
            color: cs.primary,
          ),
          title: t.statsTopReason,
          subtitle: top == null
              ? t.statsNoReason
              : '${top.key.label(t)} · ${t.statsTimes(top.value)}',
        ),
      ],
    );
  }
}

// Một dòng nhận xét: biểu tượng tròn bên trái, tiêu đề nhỏ và nội dung
class _InsightTile extends StatelessWidget {
  final Color color;
  final Widget leading;
  final String title;
  final String subtitle;

  const _InsightTile({
    required this.color,
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: leading,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}