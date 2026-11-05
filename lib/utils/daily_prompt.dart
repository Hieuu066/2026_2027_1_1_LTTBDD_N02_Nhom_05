import '../l10n/app_localizations.dart';

// Câu hỏi gợi ý viết nhật ký, mỗi ngày một câu
class DailyPrompt {
  // Danh sách 7 câu hỏi theo ngôn ngữ đang chọn
  static List<String> getAll(AppLocalizations t) {
    return [
      t.prompt1,
      t.prompt2,
      t.prompt3,
      t.prompt4,
      t.prompt5,
      t.prompt6,
      t.prompt7,
    ];
  }

  // Câu hỏi của hôm nay: mỗi ngày một câu, hết thì quay vòng lại
  static String getToday(AppLocalizations t) {
    List<String> prompts = getAll(t);
    DateTime now = DateTime.now();

    // Hôm nay là ngày thứ mấy trong năm (ngày 1/1 là 0)
    int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;

    // Chia lấy dư cho 7 để ra vị trí từ 0 đến 6
    int index = dayOfYear % prompts.length;
    return prompts[index];
  }
}
