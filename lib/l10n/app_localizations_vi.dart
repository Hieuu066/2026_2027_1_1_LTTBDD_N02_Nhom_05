// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Nhật ký cảm xúc';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navCalendar => 'Lịch';

  @override
  String get navStats => 'Thống kê';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get calendarTitle => 'Lịch';

  @override
  String get calendarNoEntry => 'Ngày này chưa có nhật ký';

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get statsPieTitle => 'Tỷ lệ cảm xúc';

  @override
  String get statsBarTitle => 'Cảm xúc theo tuần';

  @override
  String get statsNoData => 'Chưa có dữ liệu';

  @override
  String get emotionVeryHappy => 'Rất vui';

  @override
  String get emotionHappy => 'Vui';

  @override
  String get emotionNeutral => 'Bình thường';

  @override
  String get emotionSad => 'Buồn';

  @override
  String get emotionVerySad => 'Rất buồn';
}
