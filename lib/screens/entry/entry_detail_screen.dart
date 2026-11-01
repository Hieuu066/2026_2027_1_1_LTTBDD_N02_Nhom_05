import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';

// Màn xem chi tiết một nhật ký
class EntryDetailScreen extends StatelessWidget {
  final MoodEntry entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    // watch: khi nhật ký bị sửa thì màn này tự cập nhật
    context.watch<MoodProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(t.detailTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Emoji lớn, tên cảm xúc và ngày giờ
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: entry.mood.color.withValues(alpha: 0.2),
              child: Text(entry.mood.emoji, style: const TextStyle(fontSize: 48)),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              entry.mood.label(t),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 4),
          Center(child: Text(_formatDate(entry.date))),
        ],
      ),
    );
  }

  // Dạng 31/10/2026 14:05
  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.day}/${d.month}/${d.year} ${two(d.hour)}:${two(d.minute)}';
  }
}