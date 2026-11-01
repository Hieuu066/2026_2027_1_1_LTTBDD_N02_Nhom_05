import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.calendarTitle)),
      body: Center(child: Text(t.calendarNoEntry)),
    );
  }
}