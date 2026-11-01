import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/reminder_provider.dart';
import '../../providers/theme_provider.dart';

// Giao diện, ngôn ngữ, giờ nhắc
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Chọn giờ
  Future<void> _pickTime(
      BuildContext context, ReminderProvider reminder) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: reminder.time,
    );
    if (picked != null) reminder.setTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = context.watch<ThemeProvider>();
    final locale = context.watch<LocaleProvider>();
    final reminder = context.watch<ReminderProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Giao diện
          Text(t.themeLabel, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                icon: const Icon(Icons.light_mode),
                label: Text(t.themeLight),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: const Icon(Icons.dark_mode),
                label: Text(t.themeDark),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: const Icon(Icons.settings_suggest),
                label: Text(t.themeSystem),
              ),
            ],
            selected: {theme.mode},
            onSelectionChanged: (s) => theme.setMode(s.first),
          ),
          const SizedBox(height: 24),

          // Ngôn ngữ
          Text(t.languageLabel, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: 'vi',
                label: Text(t.languageVietnamese),
              ),
              ButtonSegment(
                value: 'en',
                label: Text(t.languageEnglish),
              ),
            ],
            selected: {locale.locale.languageCode},
            onSelectionChanged: (s) => locale.setLocale(Locale(s.first)),
          ),
          const SizedBox(height: 24),

          // Nhắc ghi nhật ký
          Text(t.reminderLabel, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(t.reminderSwitchTitle),
                  value: reminder.enabled,
                  onChanged: reminder.setEnabled,
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(t.reminderTimeTitle),
                  trailing: Text(
                    reminder.time.format(context),
                    style: textTheme.titleMedium,
                  ),
                  // Tắt nhắc thì không cho chọn giờ
                  enabled: reminder.enabled,
                  onTap: () => _pickTime(context, reminder),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}