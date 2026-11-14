import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/section_card.dart';

// Màn xem chi tiết một nhật ký
class EntryDetailScreen extends StatelessWidget {
  final MoodEntry entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // watch: khi nhật ký bị sửa thì màn này tự cập nhật
    context.watch<MoodProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.detailTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: cs.error),
            tooltip: t.detailDelete,
            onPressed: () => _confirmDelete(context, t),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Phần đầu: nền chuyển màu theo cảm xúc, emoji lớn, tên và ngày giờ
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  entry.mood.color.withValues(alpha: 0.4),
                  entry.mood.color.withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: cs.surface,
                  child: Text(
                    entry.mood.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  entry.mood.label(t),
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule, size: 16, color: cs.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(entry.date),
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Mức độ 1-10
          SectionCard(
            title: t.detailLevel,
            icon: Icons.bolt_outlined,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: entry.level / 10,
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(6),
                    color: entry.mood.color,
                    backgroundColor: entry.mood.color.withValues(alpha: 0.15),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${entry.level}/10',
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Lý do
          SectionCard(
            title: t.detailReasons,
            icon: Icons.label_outline,
            child: entry.reasons.isEmpty
                ? Text(
                    t.detailNoReasons,
                    style: TextStyle(color: cs.onSurfaceVariant),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final r in entry.reasons)
                        Chip(
                          avatar: Icon(r.icon, size: 18, color: cs.primary),
                          label: Text(r.label(t)),
                          backgroundColor:
                              cs.primaryContainer.withValues(alpha: 0.5),
                          side: BorderSide.none,
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 12),

          // Ghi chú
          SectionCard(
            title: t.detailNote,
            icon: Icons.edit_note,
            child: Text(
              entry.note.isEmpty ? t.entryNoNote : entry.note,
              style: textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
          ),
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