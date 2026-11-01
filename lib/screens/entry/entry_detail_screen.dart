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
      appBar: AppBar(
        title: Text(t.detailTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: t.detailDelete,
            onPressed: () => _confirmDelete(context, t),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Emoji lớn, tên cảm xúc và ngày giờ
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: entry.mood.color.withValues(alpha: 0.2),
              child: Text(
                entry.mood.emoji,
                style: const TextStyle(fontSize: 48),
              ),
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
          const SizedBox(height: 24),

          // Mức độ 1-10
          Text(t.detailLevel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: entry.level / 10,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                  color: entry.mood.color,
                ),
              ),
              const SizedBox(width: 12),
              Text('${entry.level}/10'),
            ],
          ),
          const SizedBox(height: 24),

          // Lý do
          Text(t.detailReasons, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (entry.reasons.isEmpty)
            Text(t.detailNoReasons)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final r in entry.reasons)
                  Chip(
                    avatar: Icon(r.icon, size: 18),
                    label: Text(r.label(t)),
                  ),
              ],
            ),
          const SizedBox(height: 24),

          // Ghi chú
          Text(t.detailNote, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(entry.note.isEmpty ? t.entryNoNote : entry.note),
        ],
      ),
    );
  }

  // Dạng 31/10/2026 14:05
  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.day}/${d.month}/${d.year} ${two(d.hour)}:${two(d.minute)}';
  }

  // Hỏi xác nhận rồi xóa, xóa xong thì quay về màn trước
  Future<void> _confirmDelete(BuildContext context, AppLocalizations t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.detailDeleteTitle),
        content: Text(t.detailDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.detailCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.detailDelete),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    context.read<MoodProvider>().deleteEntry(entry);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(t.detailDeleted)));
  }
}