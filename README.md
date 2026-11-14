# 🌈 Nhật ký cảm xúc (Mood Journal)

> **Bài tập lớn môn Lập trình thiết bị di động – Trường Đại học Phenikaa**
> Repository: `2026_2027_1_1_LTTBDD_N02_Nhom_05`

---

## 1. Thông tin nhóm

| STT | Họ và tên       | Mã sinh viên | Lớp | GitHub     | Vai trò                            |
| --- | --------------- | ------------ | --- | ---------- | ---------------------------------- |
| 1   | Đỗ Đình Hiệu    | 24100183     | N02 | Hieuu066   | Thành viên A – Nhật ký & Danh sách |
| 2   | Phạm Năng Khang | 24100032     | N02 | khangpham  | Thành viên B – Lịch & Thống kê     |
| 3   | Vũ Bá Huân      | 24100134     | N02 | HuanVu3003 | Thành viên C – Hệ thống & Cài đặt  |

- **Nhóm:** Nhóm 05 – Lớp học phần N02
- **Giảng viên:** ThS. Nguyễn Xuân Quế – que.nguyenxuan@phenikaa-uni.edu.vn (đã được thêm vào Repository)
- **Học kỳ:** 2026 – 2027, học kỳ 1

---

## 2. Giới thiệu đề tài

**Nhật ký cảm xúc** là ứng dụng di động giúp người dùng ghi lại cảm xúc mỗi ngày, nhìn lại hành trình cảm xúc của bản thân và hiểu rõ hơn điều gì ảnh hưởng đến tâm trạng của mình.

Mỗi lần ghi, người dùng chọn một biểu tượng cảm xúc, chỉnh mức độ, chọn lý do (học tập, bạn bè, gia đình...), viết vài dòng ghi chú và có thể gắn một ảnh của ngày. Ứng dụng tổng hợp lại bằng lịch màu, biểu đồ thống kê và thử thách 7 ngày chăm sóc bản thân.

### Mục tiêu

- Xây dựng ứng dụng Flutter có giao diện đẹp, thân thiện, nhiều màn hình, nhiều loại widget.
- Hỗ trợ 2 ngôn ngữ: Tiếng Việt và English.
- Không dùng thuật toán phức tạp; dữ liệu lưu tạm trong biến để kiểm thử (khi mở ứng dụng có sẵn vài nhật ký mẫu).

> Đề tài hợp lệ: không thuộc nhóm thương mại điện tử hay quản lý chi tiêu.

---

## 3. Chức năng chính

### 3.1. Ghi nhật ký

- Chọn 1 trong 5 cảm xúc: Rất vui 😄, Vui 🙂, Bình thường 😐, Buồn 😢, Rất buồn 😡.
- Chỉnh mức độ cảm xúc (1–10) bằng thanh trượt.
- Chọn lý do: Học tập, Bạn bè, Gia đình, Sức khỏe, Công việc, Khác.
- Viết ghi chú tự do.
- Gắn một ảnh của ngày từ thư viện ảnh; ảnh hiện làm nền thẻ nhật ký.
- Chọn cảm xúc nhanh ngay trên Trang chủ.

### 3.2. Quản lý nhật ký

- Xem 5 nhật ký gần đây trên Trang chủ và danh sách tất cả nhật ký.
- Xem chi tiết, sửa (nút ✏️ ở màn Chi tiết), xóa (vuốt để xóa, có nút Hoàn tác).
- Tìm kiếm theo từ khóa trong ghi chú, lọc theo cảm xúc.

### 3.3. Lịch cảm xúc

- Lịch tháng, mỗi ngày có nhật ký hiển thị tối đa 3 chấm màu theo cảm xúc.
- Chạm vào ngày để xem lại nhật ký ngày đó, chạm vào nhật ký để xem chi tiết.

### 3.4. Thống kê

- Chọn tháng cần xem bằng mũi tên trái/phải.
- Biểu đồ tròn: tỷ lệ các cảm xúc trong tháng.
- Biểu đồ cột: điểm cảm xúc trung bình theo từng tuần (5 = rất vui, 1 = rất buồn).
- Nhận xét đơn giản: ngày vui nhất, lý do xuất hiện nhiều nhất.

### 3.5. Cài đặt & Hệ thống

- Đổi ngôn ngữ Việt / Anh.
- Đổi giao diện sáng / tối / theo hệ thống.
- Bật/tắt nhắc ghi nhật ký và đặt giờ nhắc (hiện lưu thiết lập trong ứng dụng).
- Màn hình chào (Splash), 3 trang hướng dẫn (Onboarding) và trang Giới thiệu nhóm.

### 3.6. Chức năng riêng (tạo điểm khác biệt)

- Câu hỏi gợi ý viết nhật ký mỗi ngày (7 câu, mỗi ngày một câu, bấm “Viết về điều này” để ghi).
- Thử thách 7 ngày chăm sóc bản thân (đánh dấu hoàn thành, theo dõi tiến độ).

---

## 4. Danh sách màn hình

| STT | Màn hình             | Mô tả                                                                 | Phụ trách |
| --- | -------------------- | --------------------------------------------------------------------- | --------- |
| 1   | Splash / Onboarding  | Màn hình chào và 3 trang giới thiệu bằng `PageView`                   | C         |
| 2   | Khung chính          | 4 tab: Trang chủ, Lịch, Thống kê, Cài đặt (`BottomNavigationBar`)     | C         |
| 3   | Trang chủ            | Lời chào, chọn cảm xúc nhanh, câu hỏi gợi ý, nhật ký gần đây          | A         |
| 4   | Thêm / Sửa nhật ký   | Cảm xúc, mức độ, lý do, ghi chú, ảnh của ngày                         | A         |
| 5   | Danh sách nhật ký    | Tìm kiếm, lọc theo cảm xúc, vuốt để xóa                               | A         |
| 6   | Chi tiết nhật ký     | Xem đầy đủ một mục, nút Sửa và Xóa                                    | B         |
| 7   | Lịch                 | Lịch tháng với chấm màu cảm xúc                                       | B         |
| 8   | Thống kê             | Chọn tháng, nhận xét, biểu đồ tròn và biểu đồ cột                     | B         |
| 9   | Thử thách 7 ngày     | 7 việc chăm sóc bản thân, thanh tiến độ                               | B         |
| 10  | Cài đặt              | Ngôn ngữ, giao diện, giờ nhắc                                         | C         |
| 11  | Giới thiệu nhóm      | Thông tin thành viên, giảng viên, link GitHub                         | C         |

---

## 5. Phân công công việc

Mỗi thành viên đều tham gia code và viết báo cáo, và đều phải có khả năng trình bày mọi phần của code và báo cáo.

### 👤 Thành viên A – Nhật ký & Danh sách

**Code**

- Màn hình Trang chủ, Thêm/Sửa nhật ký, Danh sách nhật ký.
- Thêm, sửa, xóa nhật ký (CRUD), gắn ảnh của ngày.
- Tìm kiếm và lọc theo cảm xúc.
- Model `MoodEntry`, `MoodType`, `MoodReason` và `MoodProvider` (quản lý dữ liệu).
- Widget dùng chung `MoodPicker`, `MoodEntryTile`.
- Chức năng riêng: câu hỏi gợi ý viết nhật ký mỗi ngày (`DailyPrompt`).

**Báo cáo**

- SRS: Use case và Activity diagram cho nhóm chức năng ghi và quản lý nhật ký.
- SAD: Class diagram, Sequence diagram "Thêm nhật ký".
- Cây widget: Trang chủ, Thêm/Sửa, Danh sách.

### 👤 Thành viên B – Lịch & Thống kê

**Code**

- Màn hình Chi tiết nhật ký, Lịch, Thống kê.
- Lịch tháng với chấm màu cảm xúc (`table_calendar`).
- Biểu đồ tròn và biểu đồ cột (dùng `fl_chart`), chọn tháng.
- Nhận xét thống kê đơn giản (`StatsHelper`).
- Chức năng riêng: Thử thách 7 ngày chăm sóc bản thân.

**Báo cáo**

- SRS: Use case và Activity diagram cho nhóm chức năng lịch và thống kê.
- SAD: Component diagram, Sequence diagram "Xem thống kê".
- Cây widget: Chi tiết, Lịch, Thống kê, Thử thách 7 ngày.

### 👤 Thành viên C – Hệ thống & Cài đặt

**Code**

- Khởi tạo project Flutter, cấu trúc thư mục, theme sáng/tối, bảng màu.
- Splash/Onboarding, Cài đặt, Giới thiệu nhóm.
- Đa ngôn ngữ Việt/Anh (`flutter_localizations`, file `.arb`).
- Điều hướng (`BottomNavigationBar`, routes), chức năng nhắc nhở.
- Quản lý GitHub: `README.md`, nhánh, kiểm tra commit.

**Báo cáo**

- Phần mở đầu, giới thiệu, tổng hợp và định dạng báo cáo (docx + pdf).
- SAD: Sơ đồ kiến trúc tổng thể, Sequence diagram "Đổi ngôn ngữ".
- Cây widget: Khung chính, Splash, Onboarding, Cài đặt, Giới thiệu nhóm.
- Làm file thuyết trình (pptx + pdf) tóm tắt báo cáo.

### 🤝 Công việc chung

- Cả nhóm cùng thống nhất giao diện, màu sắc, bộ biểu tượng cảm xúc.
- Cả nhóm cùng thu âm và quay video demo (thuyết minh bằng giọng thật, không dùng AI).
- Mỗi người tự rà soát phần của người khác để đủ khả năng trình bày toàn bộ.

---

## 6. Công nghệ sử dụng

| Thành phần         | Công nghệ                                                          |
| ------------------ | ------------------------------------------------------------------ |
| Framework          | Flutter (Dart)                                                     |
| Quản lý trạng thái | `provider`                                                         |
| Đa ngôn ngữ        | `flutter_localizations`, `intl` (file `.arb`)                      |
| Lịch               | `table_calendar`                                                   |
| Biểu đồ            | `fl_chart`                                                         |
| Chọn ảnh           | `image_picker`                                                     |
| Lưu dữ liệu        | Lưu tạm trong biến khi ứng dụng đang chạy (theo yêu cầu đề bài)    |
| Quản lý mã nguồn   | Git, GitHub                                                        |
| Vẽ biểu đồ UML     | draw.io / StarUML / Lucidchart (không dùng AI, không vẽ bằng code) |

---

## 7. Cấu trúc thư mục

```
lib/
├─ main.dart              # Đăng ký provider, cấu hình MaterialApp
├─ core/
│  ├─ routes/             # AppRoutes: định tuyến giữa các màn hình
│  └─ theme/              # AppTheme, AppColors: giao diện sáng/tối, màu cảm xúc
├─ l10n/                  # Đa ngôn ngữ (app_vi.arb, app_en.arb) và mã sinh tự động
├─ models/                # MoodEntry, MoodType, MoodReason
├─ providers/             # MoodProvider, ThemeProvider, LocaleProvider, ReminderProvider
├─ screens/
│  ├─ main_shell.dart     # Khung chính 4 tab
│  ├─ splash/             # Splash, Onboarding
│  ├─ home/               # Trang chủ
│  ├─ entry/              # Thêm/Sửa, Chi tiết nhật ký
│  ├─ list/               # Danh sách nhật ký
│  ├─ calendar/           # Lịch cảm xúc
│  ├─ stats/              # Thống kê, biểu đồ, nhận xét
│  ├─ challenge/          # Thử thách 7 ngày
│  ├─ settings/           # Cài đặt
│  └─ about/              # Giới thiệu nhóm
├─ widgets/               # MoodPicker, MoodEntryTile
└─ utils/                 # DailyPrompt (câu hỏi gợi ý), StatsHelper (tính thống kê)
```

---

## 8. Hướng dẫn chạy ứng dụng

**Yêu cầu:** Flutter SDK bản ổn định (Dart 3.13 trở lên), Android Studio hoặc VS Code, máy ảo Android, điện thoại Android hoặc trình duyệt Chrome.

```bash
# 1. Clone repository
git clone https://github.com/Hieuu066/2026_2027_1_1_LTTBDD_N02_Nhom_05.git
cd 2026_2027_1_1_LTTBDD_N02_Nhom_05

# 2. Cài đặt thư viện
flutter pub get

# 3. Chạy ứng dụng
flutter run              # trên máy ảo hoặc điện thoại đang kết nối
flutter run -d chrome    # trên trình duyệt Chrome
```

> Dữ liệu chỉ lưu tạm trong bộ nhớ: tắt ứng dụng thì nhật ký mới sẽ mất, khi mở lại có sẵn vài nhật ký mẫu.

---

## 9. Quy ước làm việc trên GitHub

GitHub là bằng chứng nhóm tự code, vì vậy cả nhóm tuân thủ:

1. Commit đầu tiên chỉ chứa code mẫu của Flutter (`flutter create`).
2. Mỗi commit phải build thành công (chạy `flutter analyze` và `flutter run` trước khi commit).
3. Mỗi commit chỉ thay đổi ít code, làm một việc nhỏ.
4. Commit message viết rõ thay đổi gì, ví dụ:
   - `feat: thêm màn hình danh sách nhật ký`
   - `fix: sửa lỗi lệch ngày trên lịch`
   - `style: chỉnh màu thẻ cảm xúc`
   - `docs: cập nhật README`
5. Mỗi thành viên làm trên nhánh riêng (nhóm đã dùng `feature/entry-a`, `feature/calendar-b`, `feature/stats`, `nguoi-c`...), sau đó gộp vào `main` bằng Pull Request và có người trong nhóm xem lại.
6. Mỗi ngày trước khi làm, chạy `git pull origin main` để lấy code mới nhất, tránh xung đột.
7. Không commit thư mục `build/`.

---

## 10. Sản phẩm nộp

- Báo cáo (tiếng Việt) gồm 2 phần:
  - **SRS:** Biểu đồ use case, biểu đồ hoạt động.
  - **SAD:** Sơ đồ kiến trúc tổng thể, biểu đồ thành phần, biểu đồ lớp, biểu đồ tuần tự, cây widget của các màn hình.
- Có link GitHub; biểu đồ vẽ bằng phần mềm vẽ và có minh chứng.
- **Nộp bản mềm:** 1 thành viên nộp trên Canvas.

```
Nhóm_05.zip
├─ Code/            # Không bao gồm thư mục build
├─ Báo cáo/         # .docx + .pdf
├─ Thuyết trình/    # .pptx + .pdf (tối đa 10 trang)
└─ Demo/            # Video tối đa 5 phút, tối đa 100 MB
```

- **Nộp bản cứng:** In chung 1 quyển, nộp về ICSLab A4-705 (8:00–20:00, thứ 2 đến thứ 7), hạn nộp sau hạn bản mềm 3 ngày.

---

## 11. Tiến độ dự kiến

| Ngày | Công việc                                                | Kết quả                 |
| ---- | -------------------------------------------------------- | ----------------------- |
| 1    | Chốt đề tài, tạo repo, khởi tạo Flutter, thêm giảng viên | Commit đầu tiên, README |
| 2    | Dựng khung giao diện, theme, điều hướng, đa ngôn ngữ     | Khung app chạy được     |
| 3–4  | Làm các màn hình chính (A, B, C song song)               | Tính năng cốt lõi       |
| 5    | Lịch, thống kê, cài đặt, chức năng riêng                 | App hoàn chỉnh          |
| 6    | Kiểm thử, sửa lỗi, chỉnh giao diện                       | Bản ổn định             |
| 7    | Viết báo cáo, vẽ biểu đồ UML, làm slide                  | Báo cáo + slide         |
| 8    | Quay demo, rà soát, nộp bản mềm và bản cứng              | Nộp bài                 |

---

## 12. Liên kết

- **GitHub:** https://github.com/Hieuu066/2026_2027_1_1_LTTBDD_N02_Nhom_05
- **Giảng viên:** que.nguyenxuan@phenikaa-uni.edu.vn

---

_Bài tập lớn môn Lập trình thiết bị di động – Trường Đại học Phenikaa – Học kỳ 1, năm học 2026–2027._
