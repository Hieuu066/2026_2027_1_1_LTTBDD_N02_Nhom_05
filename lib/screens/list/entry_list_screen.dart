import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../widgets/mood_entry_tile.dart';
import '../entry/entry_detail_screen.dart';

// Màn Danh sách: xem tất cả nhật ký
class EntryListScreen extends StatefulWidget {
  const EntryListScreen({super.key});

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
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

    // Tất cả nhật ký, mới nhất ở trên
    List<MoodEntry> entries = moodProvider.entries;

    return Scaffold(
      appBar: AppBar(title: Text(t.listTitle)),
      body: entries.isEmpty
          // Không có nhật ký nào
          ? Center(child: Text(t.listEmpty))
          // Có nhật ký thì hiện danh sách
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                MoodEntry entry = entries[index];
                return MoodEntryTile(
                  entry: entry,
                  onTap: () => _openDetail(entry),
                );
              },
            ),
    );
  }
}
