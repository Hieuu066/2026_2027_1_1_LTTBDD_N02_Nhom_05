import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/mood_entry.dart';

// Thẻ hiển thị tóm tắt 1 nhật ký. Có ảnh thì ảnh làm nền thẻ.
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

    // Nhật ký này có ảnh không
    bool hasImage = entry.image != null;

    return Card(
      // Cắt ảnh nền theo góc bo tròn của thẻ
      clipBehavior: Clip.antiAlias,
      child: Ink(
        // Có ảnh thì dùng ảnh làm nền, phủ thêm một lớp tối cho chữ dễ đọc
        decoration: hasImage
            ? BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(entry.image!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.45),
                    BlendMode.darken,
                  ),
                ),
              )
            : null,
        child: ListTile(
          onTap: onTap,
          // Có ảnh thì chữ màu trắng, không có thì giữ màu mặc định
          textColor: hasImage ? Colors.white : null,
          // Có ảnh thì thẻ cao hơn một chút để thấy rõ ảnh
          contentPadding: hasImage
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
              : null,
          // Bên trái: hình tròn có emoji
          leading: CircleAvatar(
            backgroundColor: hasImage
                ? Colors.white.withValues(alpha: 0.85)
                : entry.mood.color.withValues(alpha: 0.2),
            child: Text(entry.mood.emoji, style: const TextStyle(fontSize: 22)),
          ),
          // Dòng chính: tên cảm xúc và mức độ, ví dụ "Vui · 7/10"
          title: Text(
            '${entry.mood.label(t)} · ${entry.level}/10',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Dòng phụ: ghi chú, tối đa 2 dòng, dài quá thì hiện "..."
          subtitle: Text(
            noteText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // Bên phải: ngày
          trailing: Text(dateText),
        ),
      ),
    );
  }
}
