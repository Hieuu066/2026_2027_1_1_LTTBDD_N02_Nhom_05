import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_type.dart';

// Biểu đồ cột: điểm cảm xúc trung bình của từng tuần trong tháng
class WeeklyBarChart extends StatelessWidget {
  final List<double> averages; // mỗi phần tử là 1 tuần, từ 0 đến 5

  const WeeklyBarChart({super.key, required this.averages});

  // Màu cột theo điểm: điểm càng cao càng xanh
  Color _colorOf(double avg) {
    final index = (5 - avg.round()).clamp(0, 4);
    return MoodType.values[index].color;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 5,
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (value, meta) =>
                    Text(value.toInt().toString()),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(t.statsWeekLabel(value.toInt() + 1)),
                ),
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < averages.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: averages[i],
                    width: 22,
                    color: _colorOf(averages[i]),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    // Thanh nền mờ để thấy rõ cột đạt bao nhiêu trên thang 5
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 5,
                      color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}