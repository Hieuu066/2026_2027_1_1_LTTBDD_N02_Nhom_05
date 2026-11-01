import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhật ký cảm xúc'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get navHome;

  /// No description provided for @navCalendar.
  ///
  /// In vi, this message translates to:
  /// **'Lịch'**
  String get navCalendar;

  /// No description provided for @navStats.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get navStats;

  /// No description provided for @navSettings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get navSettings;

  /// No description provided for @calendarTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lịch'**
  String get calendarTitle;

  /// No description provided for @calendarNoEntry.
  ///
  /// In vi, this message translates to:
  /// **'Ngày này chưa có nhật ký'**
  String get calendarNoEntry;

  /// No description provided for @statsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get statsTitle;

  /// No description provided for @statsPieTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tỷ lệ cảm xúc'**
  String get statsPieTitle;

  /// No description provided for @statsBarTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cảm xúc theo tuần'**
  String get statsBarTitle;

  /// No description provided for @statsNoData.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có dữ liệu'**
  String get statsNoData;

  /// No description provided for @emotionVeryHappy.
  ///
  /// In vi, this message translates to:
  /// **'Rất vui'**
  String get emotionVeryHappy;

  /// No description provided for @emotionHappy.
  ///
  /// In vi, this message translates to:
  /// **'Vui'**
  String get emotionHappy;

  /// No description provided for @emotionNeutral.
  ///
  /// In vi, this message translates to:
  /// **'Bình thường'**
  String get emotionNeutral;

  /// No description provided for @emotionSad.
  ///
  /// In vi, this message translates to:
  /// **'Buồn'**
  String get emotionSad;

  /// No description provided for @emotionVerySad.
  ///
  /// In vi, this message translates to:
  /// **'Rất buồn'**
  String get emotionVerySad;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi sáng 👋'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi chiều 👋'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi tối 👋'**
  String get homeGreetingEvening;

  /// No description provided for @homeQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay bạn cảm thấy thế nào?'**
  String get homeQuestion;

  /// No description provided for @homeTodayDone.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay bạn đã ghi nhật ký rồi. Muốn ghi thêm không?'**
  String get homeTodayDone;

  /// No description provided for @homeRecentTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhật ký gần đây'**
  String get homeRecentTitle;

  /// No description provided for @homeSeeAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get homeSeeAll;

  /// No description provided for @homeEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa có nhật ký nào. Hãy ghi lại cảm xúc đầu tiên nhé!'**
  String get homeEmpty;

  /// No description provided for @entryAddTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm nhật ký'**
  String get entryAddTitle;

  /// No description provided for @entryEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Sửa nhật ký'**
  String get entryEditTitle;

  /// No description provided for @entryDateLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ngày'**
  String get entryDateLabel;

  /// No description provided for @entryMoodLabel.
  ///
  /// In vi, this message translates to:
  /// **'Cảm xúc'**
  String get entryMoodLabel;

  /// No description provided for @entryLevelLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ'**
  String get entryLevelLabel;

  /// No description provided for @entryReasonLabel.
  ///
  /// In vi, this message translates to:
  /// **'Lý do'**
  String get entryReasonLabel;

  /// No description provided for @entryNoteLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get entryNoteLabel;

  /// No description provided for @entryNoteHint.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay có chuyện gì?'**
  String get entryNoteHint;

  /// No description provided for @entrySave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get entrySave;

  /// No description provided for @entrySaved.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu nhật ký'**
  String get entrySaved;

  /// No description provided for @entryChooseMood.
  ///
  /// In vi, this message translates to:
  /// **'Hãy chọn một cảm xúc'**
  String get entryChooseMood;

  /// No description provided for @entryNoNote.
  ///
  /// In vi, this message translates to:
  /// **'(Không có ghi chú)'**
  String get entryNoNote;

  /// No description provided for @reasonStudy.
  ///
  /// In vi, this message translates to:
  /// **'Học tập'**
  String get reasonStudy;

  /// No description provided for @reasonFriends.
  ///
  /// In vi, this message translates to:
  /// **'Bạn bè'**
  String get reasonFriends;

  /// No description provided for @reasonFamily.
  ///
  /// In vi, this message translates to:
  /// **'Gia đình'**
  String get reasonFamily;

  /// No description provided for @reasonHealth.
  ///
  /// In vi, this message translates to:
  /// **'Sức khỏe'**
  String get reasonHealth;

  /// No description provided for @reasonWork.
  ///
  /// In vi, this message translates to:
  /// **'Công việc'**
  String get reasonWork;

  /// No description provided for @reasonOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get reasonOther;

  /// No description provided for @listTitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách nhật ký'**
  String get listTitle;

  /// No description provided for @listSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm theo ghi chú...'**
  String get listSearchHint;

  /// No description provided for @listFilterAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get listFilterAll;

  /// No description provided for @listEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không có nhật ký phù hợp'**
  String get listEmpty;

  /// No description provided for @listDeleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa nhật ký'**
  String get listDeleted;

  /// No description provided for @listUndo.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tác'**
  String get listUndo;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa nhật ký?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn xóa nhật ký này không?'**
  String get deleteConfirmMessage;

  /// No description provided for @actionCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get actionDelete;

  /// No description provided for @detailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết nhật ký'**
  String get detailTitle;

  /// No description provided for @detailLevel.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ'**
  String get detailLevel;

  /// No description provided for @detailReasons.
  ///
  /// In vi, this message translates to:
  /// **'Lý do'**
  String get detailReasons;

  /// No description provided for @detailNoReasons.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn lý do'**
  String get detailNoReasons;

  /// No description provided for @detailNote.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get detailNote;

  /// No description provided for @detailDelete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get detailDelete;

  /// No description provided for @detailDeleteTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa nhật ký này?'**
  String get detailDeleteTitle;

  /// No description provided for @detailDeleteMessage.
  ///
  /// In vi, this message translates to:
  /// **'Hành động này không thể hoàn tác.'**
  String get detailDeleteMessage;

  /// No description provided for @detailCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get detailCancel;

  /// No description provided for @detailDeleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa nhật ký'**
  String get detailDeleted;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingsTitle;

  /// No description provided for @themeLabel.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get themeLabel;

  /// No description provided for @themeLight.
  ///
  /// In vi, this message translates to:
  /// **'Sáng'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In vi, this message translates to:
  /// **'Tối'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In vi, this message translates to:
  /// **'Theo hệ thống'**
  String get themeSystem;

  /// No description provided for @languageLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get languageLabel;

  /// No description provided for @languageVietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnamese;

  /// No description provided for @languageEnglish.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @reminderLabel.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc ghi nhật ký'**
  String get reminderLabel;

  /// No description provided for @reminderSwitchTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc hằng ngày'**
  String get reminderSwitchTitle;

  /// No description provided for @reminderTimeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giờ nhắc'**
  String get reminderTimeTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
