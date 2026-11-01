import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.statsTitle)),
      body: Center(child: Text(t.statsNoData)),
    );
  }
}