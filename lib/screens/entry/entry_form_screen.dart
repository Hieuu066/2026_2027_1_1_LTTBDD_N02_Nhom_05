import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../models/mood_reason.dart';
import '../../models/mood_type.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_picker.dart';

// Màn Thêm nhật ký
class EntryFormScreen extends StatefulWidget {
  final MoodType?
  initialMood; // cảm xúc chọn sẵn từ Trang chủ (có thể không có)

  const EntryFormScreen({super.key, this.initialMood});

  @override
  State<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  MoodType? _selectedMood; // cảm xúc đang chọn
  double _level = 5; // mức độ, mặc định là 5
  final List<MoodReason> _selectedReasons = []; // các lý do đã chọn
  final TextEditingController _noteController =
      TextEditingController(); // ô ghi chú

  @override
  void initState() {
    super.initState();
    // Lấy cảm xúc được chọn sẵn (nếu có)
    _selectedMood = widget.initialMood;
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

  // Bấm nút Lưu
  void _save() {
    final t = AppLocalizations.of(context)!;

    // Chưa chọn cảm xúc thì nhắc người dùng và dừng lại
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.entryChooseMood)));
      return;
    }

    // Tạo nhật ký mới rồi thêm vào kho
    final moodProvider = context.read<MoodProvider>();
    MoodEntry newEntry = MoodEntry(
      id: moodProvider.createId(),
      date: DateTime.now(),
      mood: _selectedMood!,
      level: _level.round(),
      reasons: List.from(_selectedReasons),
      note: _noteController.text.trim(),
    );
    moodProvider.addEntry(newEntry);

    // Báo đã lưu và quay về màn trước
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(t.entrySaved)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.entryAddTitle)),
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
              hintText: t.entryNoteHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // Nút Lưu
          FilledButton(onPressed: _save, child: Text(t.entrySave)),
        ],
      ),
    );
  }
}
