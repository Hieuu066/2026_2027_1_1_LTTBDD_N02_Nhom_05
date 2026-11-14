import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/mood_provider.dart';
import '../../utils/stats_helper.dart';
import '../../widgets/section_card.dart';
import '../challenge/challenge_controller.dart';
import '../challenge/challenge_screen.dart';
import 'mood_pie_chart.dart';
import 'stats_insights.dart';
import 'weekly_bar_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Tháng đang xem (luôn là ngày mùng 1)
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  // Tiến độ thử thách, giữ ở đây để không mất khi chuyển tab
  final ChallengeController _challenge = ChallengeController();

  @override
  void dispose() {
    _challenge.dispose();
    super.dispose();
  }

  // delta = -1 lùi một tháng, +1 tiến một tháng
  void _changeMonth(int delta) {
    setState(() => _month = DateTime(_month.year, _month.month + delta));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    // watch: khi nhật ký thay đổi thì thống kê tự cập nhật
    final all = context.watch<MoodProvider>().entries;

    final entries = StatsHelper.entriesOfMonth(all, _month);
    final monthText = DateFormat.yMMMM(locale).format(_month);

    return Scaffold(
      appBar: AppBar(title: Text(t.statsTitle), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bộ chọn tháng dạng viên thuốc
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left_rounded, color: cs.primary),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  monthText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right_rounded, color: cs.primary),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (entries.isEmpty)
            // Tháng này chưa có nhật ký nào
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.insights_outlined, size: 56, color: cs.outline),
                  const SizedBox(height: 8),
                  Text(
                    t.statsNoData,
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            )
          else ...[
            SectionCard(
              title: t.statsInsightsTitle,
              icon: Icons.emoji_events_outlined,
              child: StatsInsights(entries: entries),
            ),
            const SizedBox(height: 12),
            SectionCard(
              title: t.statsPieTitle,
              icon: Icons.pie_chart_outline,
              child: MoodPieChart(counts: StatsHelper.countByMood(entries)),
            ),
            const SizedBox(height: 12),
            SectionCard(
              title: t.statsBarTitle,
              icon: Icons.bar_chart_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeeklyBarChart(
                    averages: StatsHelper.weeklyAverage(entries, _month),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.statsBarHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],

          // Thẻ mở thử thách 7 ngày (luôn hiện, kể cả tháng chưa có dữ liệu)
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: cs.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              leading: CircleAvatar(
                backgroundColor: cs.primary,
                child: Icon(Icons.self_improvement, color: cs.onPrimary),
              ),
              title: Text(
                t.challengeTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
              subtitle: ListenableBuilder(
                listenable: _challenge,
                builder: (context, _) => Text(
                  t.challengeProgress(_challenge.doneCount),
                  style: TextStyle(color: cs.onPrimaryContainer),
                ),
              ),
              trailing:
                  Icon(Icons.chevron_right, color: cs.onPrimaryContainer),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChallengeScreen(controller: _challenge),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}