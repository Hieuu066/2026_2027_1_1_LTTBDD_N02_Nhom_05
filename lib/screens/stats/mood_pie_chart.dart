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
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                // Chỉ vẽ những cảm xúc có ít nhất 1 nhật ký
                for (final m in MoodType.values)
                  if (counts[m]! > 0)
                    PieChartSectionData(
                      value: counts[m]!.toDouble(),
                      color: m.color,
                      radius: 60,
                      title: '${(counts[m]! * 100 / total).round()}%',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Chú thích: màu, emoji, tên và số lượng
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final m in MoodType.values)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: m.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('${m.emoji} ${m.label(t)}: ${counts[m]}'),
                ],
              ),
          ],
        ),
      ],
    );
  }
}