import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/mood_provider.dart';
import '../../utils/stats_helper.dart';
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
    final locale = Localizations.localeOf(context).toString();
    // watch: khi nhật ký thay đổi thì thống kê tự cập nhật
    final all = context.watch<MoodProvider>().entries;

    final entries = StatsHelper.entriesOfMonth(all, _month);
    final monthText = DateFormat.yMMMM(locale).format(_month);

    return Scaffold(
      appBar: AppBar(title: Text(t.statsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bộ chọn tháng
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _changeMonth(-1),
              ),
              Text(monthText, style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (entries.isEmpty)
            // Tháng này chưa có nhật ký nào
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(child: Text(t.statsNoData)),
            )
          else ...[
            Text(
              t.statsInsightsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            StatsInsights(entries: entries),
            const SizedBox(height: 24),
            Text(
              t.statsPieTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            MoodPieChart(counts: StatsHelper.countByMood(entries)),
            const SizedBox(height: 32),
            Text(
              t.statsBarTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            WeeklyBarChart(
              averages: StatsHelper.weeklyAverage(entries, _month),
            ),
            const SizedBox(height: 8),
            Text(t.statsBarHint, style: Theme.of(context).textTheme.bodySmall),
          ],

          // Thẻ mở thử thách 7 ngày (luôn hiện, kể cả tháng chưa có dữ liệu)
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.self_improvement),
              title: Text(t.challengeTitle),
              subtitle: ListenableBuilder(
                listenable: _challenge,
                builder: (context, _) =>
                    Text(t.challengeProgress(_challenge.doneCount)),
              ),
              trailing: const Icon(Icons.chevron_right),
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