import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/mood_type.dart';

// Hàng 5 biểu tượng cảm xúc để người dùng chọn
class MoodPicker extends StatelessWidget {
  final MoodType? selectedMood; // cảm xúc đang được chọn (có thể chưa chọn)
  final void Function(MoodType mood)
  onSelect; // hàm chạy khi chạm vào 1 cảm xúc

  const MoodPicker({
    super.key,
    required this.selectedMood,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    // Tạo danh sách 5 ô, mỗi ô là 1 cảm xúc
    List<Widget> items = [];
    for (MoodType mood in MoodType.values) {
      bool isSelected = mood == selectedMood;

      items.add(
        Expanded(
          child: GestureDetector(
            onTap: () => onSelect(mood),
            child: Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                // Ô được chọn thì tô màu nhạt và có viền
                color: isSelected
                    ? mood.color.withValues(alpha: 0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? mood.color : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(mood.emoji, style: const TextStyle(fontSize: 30)),
                  const SizedBox(height: 4),
                  Text(
                    mood.label(t),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }
}
