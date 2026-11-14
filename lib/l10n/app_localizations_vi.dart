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

  @override
  String get homeGreetingMorning => 'Chào buổi sáng 👋';

  @override
  String get homeGreetingAfternoon => 'Chào buổi chiều 👋';

  @override
  String get homeGreetingEvening => 'Chào buổi tối 👋';

  @override
  String get homeQuestion => 'Hôm nay bạn cảm thấy thế nào?';

  @override
  String get homeTodayDone =>
      'Hôm nay bạn đã ghi nhật ký rồi. Muốn ghi thêm không?';

  @override
  String get homeRecentTitle => 'Nhật ký gần đây';

  @override
  String get homeSeeAll => 'Xem tất cả';

  @override
  String get homeEmpty =>
      'Bạn chưa có nhật ký nào. Hãy ghi lại cảm xúc đầu tiên nhé!';

  @override
  String get entryAddTitle => 'Thêm nhật ký';

  @override
  String get entryEditTitle => 'Sửa nhật ký';

  @override
  String get entryDateLabel => 'Ngày';

  @override
  String get entryMoodLabel => 'Cảm xúc';

  @override
  String get entryLevelLabel => 'Mức độ';

  @override
  String get entryReasonLabel => 'Lý do';

  @override
  String get entryNoteLabel => 'Ghi chú';

  @override
  String get entryNoteHint => 'Hôm nay có chuyện gì?';

  @override
  String get entrySave => 'Lưu';

  @override
  String get entrySaved => 'Đã lưu nhật ký';

  @override
  String get entryChooseMood => 'Hãy chọn một cảm xúc';

  @override
  String get entryNoNote => '(Không có ghi chú)';

  @override
  String get reasonStudy => 'Học tập';

  @override
  String get reasonFriends => 'Bạn bè';

  @override
  String get reasonFamily => 'Gia đình';

  @override
  String get reasonHealth => 'Sức khỏe';

  @override
  String get reasonWork => 'Công việc';

  @override
  String get reasonOther => 'Khác';

  @override
  String get listTitle => 'Danh sách nhật ký';

  @override
  String get listSearchHint => 'Tìm theo ghi chú...';

  @override
  String get listFilterAll => 'Tất cả';

  @override
  String get listEmpty => 'Không có nhật ký phù hợp';

  @override
  String get listDeleted => 'Đã xóa nhật ký';

  @override
  String get listUndo => 'Hoàn tác';

  @override
  String get deleteConfirmTitle => 'Xóa nhật ký?';

  @override
  String get deleteConfirmMessage => 'Bạn có chắc muốn xóa nhật ký này không?';

  @override
  String get actionCancel => 'Hủy';

  @override
  String get actionDelete => 'Xóa';

  @override
  String get detailTitle => 'Chi tiết nhật ký';

  @override
  String get detailLevel => 'Mức độ';

  @override
  String get detailReasons => 'Lý do';

  @override
  String get detailNoReasons => 'Chưa chọn lý do';

  @override
  String get detailNote => 'Ghi chú';

  @override
  String get detailDelete => 'Xóa';

  @override
  String get detailDeleteTitle => 'Xóa nhật ký này?';

  @override
  String get detailDeleteMessage => 'Hành động này không thể hoàn tác.';

  @override
  String get detailCancel => 'Hủy';

  @override
  String get detailDeleted => 'Đã xóa nhật ký';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get themeLabel => 'Giao diện';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeSystem => 'Theo hệ thống';

  @override
  String get languageLabel => 'Ngôn ngữ';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageEnglish => 'English';

  @override
  String get reminderLabel => 'Nhắc ghi nhật ký';

  @override
  String get reminderSwitchTitle => 'Nhắc hằng ngày';

  @override
  String get reminderTimeTitle => 'Giờ nhắc';

  @override
  String statsWeekLabel(int n) {
    return 'T$n';
  }

  @override
  String get statsBarHint => 'Điểm trung bình: 5 = rất vui, 1 = rất buồn';

  @override
  String get promptTitle => '💡 Gợi ý hôm nay';

  @override
  String get promptWrite => 'Viết về điều này';

  @override
  String get prompt1 => 'Điều gì khiến bạn mỉm cười hôm nay?';

  @override
  String get prompt2 => 'Hôm nay bạn biết ơn điều gì?';

  @override
  String get prompt3 => 'Điều gì làm bạn thấy mệt nhất hôm nay?';

  @override
  String get prompt4 => 'Hôm nay bạn đã học được điều gì mới?';

  @override
  String get prompt5 => 'Hôm nay bạn đã nói chuyện với ai nhiều nhất?';

  @override
  String get prompt6 => 'Nếu được làm lại hôm nay, bạn sẽ thay đổi điều gì?';

  @override
  String get prompt7 => 'Ngày mai bạn mong chờ điều gì?';

  @override
  String get splashSlogan => 'Ghi lại cảm xúc mỗi ngày';

  @override
  String get onboardSkip => 'Bỏ qua';

  @override
  String get onboardNext => 'Tiếp';

  @override
  String get onboardStart => 'Bắt đầu';

  @override
  String get onboard1Title => 'Ghi lại cảm xúc';

  @override
  String get onboard1Body =>
      'Chọn cảm xúc của bạn mỗi ngày, chỉnh mức độ, chọn lý do và viết vài dòng ghi chú.';

  @override
  String get onboard2Title => 'Nhìn lại hành trình';

  @override
  String get onboard2Body =>
      'Xem nhật ký trên lịch màu và các biểu đồ thống kê để hiểu rõ cảm xúc của mình hơn.';

  @override
  String get onboard3Title => 'Của riêng bạn';

  @override
  String get onboard3Body =>
      'Đổi giao diện sáng hoặc tối, chọn tiếng Việt hoặc tiếng Anh và đặt giờ nhắc ghi nhật ký.';

  @override
  String get settingsAbout => 'Giới thiệu nhóm';

  @override
  String get aboutTitle => 'Giới thiệu nhóm';

  @override
  String get aboutAppDesc =>
      'Ứng dụng giúp ghi lại và theo dõi cảm xúc mỗi ngày.';

  @override
  String get aboutCourse => 'Bài tập lớn môn Lập trình thiết bị di động';

  @override
  String get aboutSchool => 'Trường Đại học Phenikaa';

  @override
  String get aboutGroup => 'Nhóm 05 – Lớp học phần N02';

  @override
  String get aboutLecturer => 'Giảng viên';

  @override
  String get aboutMembers => 'Thành viên';

  @override
  String get aboutStudentId => 'MSSV';

  @override
  String get aboutRoleA => 'Nhật ký & Danh sách';

  @override
  String get aboutRoleB => 'Lịch & Thống kê';

  @override
  String get aboutRoleC => 'Hệ thống & Cài đặt';

  @override
  String get aboutRepo => 'Mã nguồn trên GitHub';

  @override
  String get aboutCopyLink => 'Sao chép liên kết';

  @override
  String get aboutCopied => 'Đã sao chép liên kết';

  @override
  String get statsInsightsTitle => 'Điểm nổi bật';

  @override
  String get statsHappiestDay => 'Ngày vui nhất';

  @override
  String get statsTopReason => 'Lý do xuất hiện nhiều nhất';

  @override
  String get statsNoReason => 'Chưa ghi lý do nào';

  @override
  String statsTimes(int n) {
    return '$n lần';
  }

  @override
  String get challengeTitle => 'Thử thách 7 ngày chăm sóc bản thân';

  @override
  String get challengeIntro => 'Mỗi ngày làm một việc nhỏ cho chính bạn.';

  @override
  String challengeProgress(int done) {
    return 'Hoàn thành $done/7';
  }

  @override
  String challengeDay(int n) {
    return 'Ngày $n';
  }

  @override
  String get challengeReset => 'Làm lại từ đầu';

  @override
  String get challengeResetTitle => 'Làm lại thử thách từ đầu?';

  @override
  String get challengeResetMessage => 'Toàn bộ tiến độ sẽ bị xóa.';

  @override
  String get challengeCongrats => 'Tuyệt vời! Bạn đã hoàn thành cả 7 ngày.';

  @override
  String get challengeTask1 => 'Uống đủ nước trong ngày';

  @override
  String get challengeTask2 => 'Đi bộ 15 phút';

  @override
  String get challengeTask3 => 'Đi ngủ trước 23 giờ';

  @override
  String get challengeTask4 =>
      'Nhắn tin hỏi thăm một người bạn hoặc người thân';

  @override
  String get challengeTask5 => 'Dành 10 phút cho sở thích của bạn';

  @override
  String get challengeTask6 => 'Viết ra 3 điều bạn biết ơn';

  @override
  String get challengeTask7 => 'Dành 5 phút hít thở chậm';

  @override
  String get entryPhotoLabel => 'Ảnh của ngày';

  @override
  String get entryPhotoPick => 'Chọn ảnh';

  @override
  String get entryPhotoChange => 'Đổi ảnh';

  @override
  String get entryPhotoRemove => 'Bỏ ảnh';
}
