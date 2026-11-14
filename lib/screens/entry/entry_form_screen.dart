import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../models/mood_reason.dart';
import '../../models/mood_type.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_picker.dart';

// Màn Thêm / Sửa nhật ký
class EntryFormScreen extends StatefulWidget {
  final MoodType?
  initialMood; // cảm xúc chọn sẵn từ Trang chủ (có thể không có)
  final MoodEntry? entry; // nhật ký cần sửa (null = đang thêm mới)
  final String? noteHint; // câu gợi ý hiện mờ trong ô ghi chú (có thể không có)

  const EntryFormScreen({
    super.key,
    this.initialMood,
    this.entry,
    this.noteHint,
  });

  @override
  State<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  MoodType? _selectedMood; // cảm xúc đang chọn
  double _level = 5; // mức độ, mặc định là 5
  final List<MoodReason> _selectedReasons = []; // các lý do đã chọn
  final TextEditingController _noteController =
      TextEditingController(); // ô ghi chú
  Uint8List? _image; // ảnh đã chọn (có thể chưa có)

  @override
  void initState() {
    super.initState();
    MoodEntry? oldEntry = widget.entry;

    if (oldEntry != null) {
      // Đang sửa: điền sẵn dữ liệu cũ vào các ô
      _selectedMood = oldEntry.mood;
      _level = oldEntry.level.toDouble();
      _selectedReasons.addAll(oldEntry.reasons);
      _noteController.text = oldEntry.note;
      _image = oldEntry.image;
    } else {
      // Đang thêm mới: lấy cảm xúc được chọn sẵn (nếu có)
      _selectedMood = widget.initialMood;
    }
  }

  @override
  void dispose() {
    // Giải phóng ô nhập chữ khi đóng màn hình
    _noteController.dispose();
    super.dispose();
  }

  // Chọn hoặc bỏ chọn một lý do
  void _toggleReason(MoodReason reason, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedReasons.add(reason);
      } else {
        _selectedReasons.remove(reason);
      }
    });
  }

  // Mở thư viện ảnh để chọn 1 ảnh
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080, // thu nhỏ ảnh cho đỡ tốn bộ nhớ
      imageQuality: 80, // nén nhẹ ảnh
    );

    // Người dùng bấm hủy, không chọn ảnh nào
    if (file == null) return;

    // Đọc nội dung ảnh thành dãy byte
    final Uint8List bytes = await file.readAsBytes();

    // Màn hình đã bị đóng trong lúc chờ thì không làm gì nữa
    if (!mounted) return;

    setState(() {
      _image = bytes;
    });
  }

  // Bấm nút Lưu
  void _save() {
    final t = AppLocalizations.of(context)!;

    // Chưa chọn cảm xúc thì nhắc người dùng và dừng lại
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.entryChooseMood)));
      return;
    }

    final moodProvider = context.read<MoodProvider>();
    MoodEntry? oldEntry = widget.entry;

    if (oldEntry != null) {
      // Sửa: ghi dữ liệu mới vào nhật ký cũ (giữ nguyên id và ngày giờ)
      oldEntry.mood = _selectedMood!;
      oldEntry.level = _level.round();
      oldEntry.reasons = List.from(_selectedReasons);
      oldEntry.note = _noteController.text.trim();

      oldEntry.image = _image;
      moodProvider.updateEntry(oldEntry);
    } else {
      // Thêm mới: tạo nhật ký mới rồi thêm vào kho
      MoodEntry newEntry = MoodEntry(
        id: moodProvider.createId(),
        date: DateTime.now(),
        mood: _selectedMood!,
        level: _level.round(),
        reasons: List.from(_selectedReasons),
        note: _noteController.text.trim(),
        image: _image,
      );
      moodProvider.addEntry(newEntry);
    }

    // Báo đã lưu và quay về màn trước
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(t.entrySaved)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    // Tiêu đề đổi theo chế độ: Sửa hay Thêm
    String title = widget.entry != null ? t.entryEditTitle : t.entryAddTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Chọn cảm xúc
          Text(
            t.entryMoodLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          MoodPicker(
            selectedMood: _selectedMood,
            onSelect: (mood) {
              setState(() {
                _selectedMood = mood;
              });
            },
          ),
          const SizedBox(height: 24),

          // Mức độ từ 1 đến 10
          Text(
            '${t.entryLevelLabel}: ${_level.round()}/10',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: _level,
            min: 1,
            max: 10,
            divisions: 9,
            label: _level.round().toString(),
            onChanged: (value) {
              setState(() {
                _level = value;
              });
            },
          ),
          const SizedBox(height: 24),

          // Chọn lý do (chọn được nhiều)
          Text(
            t.entryReasonLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (MoodReason reason in MoodReason.values)
                FilterChip(
                  avatar: Icon(reason.icon, size: 18),
                  label: Text(reason.label(t)),
                  selected: _selectedReasons.contains(reason),
                  onSelected: (isSelected) => _toggleReason(reason, isSelected),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Ghi chú
          Text(
            t.entryNoteLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.noteHint ?? t.entryNoteHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          // Ảnh của ngày (không bắt buộc)
          Text(
            t.entryPhotoLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Có ảnh thì hiện ảnh xem trước
          if (_image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                _image!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 8),

          // Nút chọn / đổi ảnh và nút bỏ ảnh
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(
                  _image == null ? t.entryPhotoPick : t.entryPhotoChange,
                ),
              ),
              const SizedBox(width: 8),
              if (_image != null)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _image = null;
                    });
                  },
                  icon: const Icon(Icons.close),
                  label: Text(t.entryPhotoRemove),
                ),
            ],
          ),
          const SizedBox(height: 24),
          // Nút Lưu
          FilledButton(onPressed: _save, child: Text(t.entrySave)),
        ],
      ),
    );
  }
}
