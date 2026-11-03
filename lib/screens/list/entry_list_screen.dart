import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../models/mood_type.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_entry_tile.dart';
import '../entry/entry_detail_screen.dart';

// Màn Danh sách: xem, tìm kiếm, lọc nhật ký
class EntryListScreen extends StatefulWidget {
  const EntryListScreen({super.key});

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
  String _keyword = ''; // từ khóa đang tìm, ban đầu rỗng
  MoodType? _filterMood; // cảm xúc đang lọc, null = tất cả

  // Mở màn Chi tiết nhật ký (màn của Khang)
  void _openDetail(MoodEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryDetailScreen(entry: entry)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final moodProvider = context.watch<MoodProvider>();

    // Tìm theo từ khóa và lọc theo cảm xúc đang chọn
    List<MoodEntry> entries = moodProvider.search(_keyword, _filterMood);

    return Scaffold(
      appBar: AppBar(title: Text(t.listTitle)),
      body: Column(
        children: [
          // Ô tìm kiếm
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: t.listSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _keyword = value;
                });
              },
            ),
          ),

          // Bộ lọc cảm xúc, cuộn ngang
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Chip "Tất cả"
                ChoiceChip(
                  label: Text(t.listFilterAll),
                  selected: _filterMood == null,
                  onSelected: (_) {
                    setState(() {
                      _filterMood = null;
                    });
                  },
                ),
                // Mỗi cảm xúc một chip
                for (MoodType mood in MoodType.values)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ChoiceChip(
                      label: Text('${mood.emoji} ${mood.label(t)}'),
                      selected: _filterMood == mood,
                      onSelected: (_) {
                        setState(() {
                          _filterMood = mood;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Danh sách kết quả, chiếm hết phần còn lại của màn hình
          Expanded(
            child: entries.isEmpty
                ? Center(child: Text(t.listEmpty))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      MoodEntry entry = entries[index];
                      return MoodEntryTile(
                        entry: entry,
                        onTap: () => _openDetail(entry),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
