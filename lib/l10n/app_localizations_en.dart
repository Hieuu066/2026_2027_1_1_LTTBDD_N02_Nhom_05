// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mood Diary';

  @override
  String get navHome => 'Home';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navStats => 'Statistics';

  @override
  String get navSettings => 'Settings';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarNoEntry => 'No entry for this day';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsPieTitle => 'Mood distribution';

  @override
  String get statsBarTitle => 'Mood by week';

  @override
  String get statsNoData => 'No data yet';

  @override
  String get emotionVeryHappy => 'Very happy';

  @override
  String get emotionHappy => 'Happy';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionSad => 'Sad';

  @override
  String get emotionVerySad => 'Very sad';
}
