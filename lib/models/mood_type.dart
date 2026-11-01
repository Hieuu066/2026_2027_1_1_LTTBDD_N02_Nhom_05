import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';

// 5 loại cảm xúc. Mỗi loại có 1 emoji và 1 màu.
enum MoodType {
  veryHappy('😄', AppColors.moodVeryHappy),
  happy('🙂', AppColors.moodHappy),
  neutral('😐', AppColors.moodNeutral),
  sad('😢', AppColors.moodSad),
  verySad('😡', AppColors.moodVerySad);

  const MoodType(this.emoji, this.color);

  final String emoji;
  final Color color;

  // Lấy tên cảm xúc theo ngôn ngữ đang chọn (Việt/Anh)
  String label(AppLocalizations t) {
    switch (this) {
      case MoodType.veryHappy:
        return t.emotionVeryHappy;
      case MoodType.happy:
        return t.emotionHappy;
      case MoodType.neutral:
        return t.emotionNeutral;
      case MoodType.sad:
        return t.emotionSad;
      case MoodType.verySad:
        return t.emotionVerySad;
    }
  }
}
