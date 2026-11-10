import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_type.dart';

// Biểu đồ tròn tỷ lệ các cảm xúc, kèm chú thích bên dưới
class MoodPieChart extends StatelessWidget {
  final Map<MoodType, int> counts;

  const MoodPieChart({super.key, required this.counts});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final total = counts.values.fold<int>(0, (a, b) => a + b);

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 34,
              sections: [
                // Chỉ vẽ những cảm xúc có ít nhất 1 nhật ký
                for (final m in MoodType.values)
                  if (counts[m]! > 0)
                    PieChartSectionData(
                      value: counts[m]!.toDouble(),
                      color: m.color,
                      radius: 70,
                      title: '${(counts[m]! * 100 / total).round()}%',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.black54)],
                      ),
                    ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Chú thích: mỗi cảm xúc một viên thuốc màu, kèm emoji và số lượng
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final m in MoodType.values)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: m.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: m.color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${m.emoji} ${m.label(t)}: ${counts[m]}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
          ],
        ),
      ],
    );
  }
}