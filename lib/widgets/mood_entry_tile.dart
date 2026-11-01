import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/mood_entry.dart';

// Thẻ hiển thị tóm tắt 1 nhật ký
class MoodEntryTile extends StatelessWidget {
  final MoodEntry entry; // nhật ký cần hiển thị
  final VoidCallback? onTap; // hàm chạy khi chạm vào thẻ (có thể không có)

  const MoodEntryTile({super.key, required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    // Ngày dạng 31/10/2026
    String dateText =
        '${entry.date.day}/${entry.date.month}/${entry.date.year}';

    // Nếu không có ghi chú thì hiện chữ "(Không có ghi chú)"
    String noteText = entry.note.isEmpty ? t.entryNoNote : entry.note;

    return Card(
      child: ListTile(
        onTap: onTap,
        // Bên trái: hình tròn có emoji
        leading: CircleAvatar(
          backgroundColor: entry.mood.color.withValues(alpha: 0.2),
          child: Text(entry.mood.emoji, style: const TextStyle(fontSize: 22)),
        ),
        // Dòng chính: tên cảm xúc và mức độ, ví dụ "Vui · 7/10"
        title: Text(
          '${entry.mood.label(t)} · ${entry.level}/10',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Dòng phụ: ghi chú, tối đa 2 dòng, dài quá thì hiện "..."
        subtitle: Text(noteText, maxLines: 2, overflow: TextOverflow.ellipsis),
        // Bên phải: ngày
        trailing: Text(dateText),
      ),
    );
  }
}
