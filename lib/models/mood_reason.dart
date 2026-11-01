import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

// Các lý do ảnh hưởng đến cảm xúc. Mỗi lý do có 1 icon.
enum MoodReason {
  study(Icons.school),
  friends(Icons.people),
  family(Icons.home),
  health(Icons.favorite),
  work(Icons.work),
  other(Icons.more_horiz);

  const MoodReason(this.icon);

  final IconData icon;

  // Lấy tên lý do theo ngôn ngữ đang chọn
  String label(AppLocalizations t) {
    switch (this) {
      case MoodReason.study:
        return t.reasonStudy;
      case MoodReason.friends:
        return t.reasonFriends;
      case MoodReason.family:
        return t.reasonFamily;
      case MoodReason.health:
        return t.reasonHealth;
      case MoodReason.work:
        return t.reasonWork;
      case MoodReason.other:
        return t.reasonOther;
    }
  }
}
