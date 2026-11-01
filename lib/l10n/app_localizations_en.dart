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

  @override
  String get homeGreetingMorning => 'Good morning 👋';

  @override
  String get homeGreetingAfternoon => 'Good afternoon 👋';

  @override
  String get homeGreetingEvening => 'Good evening 👋';

  @override
  String get homeQuestion => 'How are you feeling today?';

  @override
  String get homeTodayDone =>
      'You have already written today. Want to add more?';

  @override
  String get homeRecentTitle => 'Recent entries';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeEmpty => 'No entries yet. Write down your first mood!';

  @override
  String get entryAddTitle => 'New entry';

  @override
  String get entryEditTitle => 'Edit entry';

  @override
  String get entryDateLabel => 'Date';

  @override
  String get entryMoodLabel => 'Mood';

  @override
  String get entryLevelLabel => 'Intensity';

  @override
  String get entryReasonLabel => 'Reasons';

  @override
  String get entryNoteLabel => 'Note';

  @override
  String get entryNoteHint => 'What happened today?';

  @override
  String get entrySave => 'Save';

  @override
  String get entrySaved => 'Entry saved';

  @override
  String get entryChooseMood => 'Please choose a mood';

  @override
  String get entryNoNote => '(No note)';

  @override
  String get reasonStudy => 'Study';

  @override
  String get reasonFriends => 'Friends';

  @override
  String get reasonFamily => 'Family';

  @override
  String get reasonHealth => 'Health';

  @override
  String get reasonWork => 'Work';

  @override
  String get reasonOther => 'Other';

  @override
  String get listTitle => 'All entries';

  @override
  String get listSearchHint => 'Search notes...';

  @override
  String get listFilterAll => 'All';

  @override
  String get listEmpty => 'No matching entries';

  @override
  String get listDeleted => 'Entry deleted';

  @override
  String get listUndo => 'Undo';

  @override
  String get deleteConfirmTitle => 'Delete entry?';

  @override
  String get deleteConfirmMessage =>
      'Are you sure you want to delete this entry?';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get detailTitle => 'Entry details';

  @override
  String get detailLevel => 'Intensity';

  @override
  String get detailReasons => 'Reasons';

  @override
  String get detailNoReasons => 'No reasons selected';

  @override
  String get detailNote => 'Note';

  @override
  String get detailDelete => 'Delete';

  @override
  String get detailDeleteTitle => 'Delete this entry?';

  @override
  String get detailDeleteMessage => 'This action cannot be undone.';

  @override
  String get detailCancel => 'Cancel';

  @override
  String get detailDeleted => 'Entry deleted';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeLabel => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'English';

  @override
  String get reminderLabel => 'Diary reminder';

  @override
  String get reminderSwitchTitle => 'Daily reminder';

  @override
  String get reminderTimeTitle => 'Reminder time';
}
