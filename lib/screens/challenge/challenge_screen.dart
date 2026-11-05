import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'challenge_controller.dart';

// Màn thử thách 7 ngày chăm sóc bản thân
class ChallengeScreen extends StatelessWidget {
  final ChallengeController controller;

  const ChallengeScreen({super.key, required this.controller});

  static const _icons = <IconData>[
    Icons.water_drop_outlined,
    Icons.directions_walk,
    Icons.bedtime_outlined,
    Icons.chat_bubble_outline,
    Icons.palette_outlined,
    Icons.favorite_border,
    Icons.self_improvement,
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final tasks = [
      t.challengeTask1,
      t.challengeTask2,
      t.challengeTask3,
      t.challengeTask4,
      t.challengeTask5,
      t.challengeTask6,
      t.challengeTask7,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t.challengeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: t.challengeReset,
            onPressed: () => _confirmReset(context, t),
          ),
        ],
      ),
      // ListenableBuilder: bấm chọn thì màn hình tự vẽ lại
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(t.challengeIntro),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: controller.doneCount / ChallengeController.taskCount,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(t.challengeProgress(controller.doneCount)),
                ],
              ),
              const SizedBox(height: 16),
              if (controller.isCompleted)
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: ListTile(
                    leading: const Text('🎉', style: TextStyle(fontSize: 28)),
                    title: Text(t.challengeCongrats),
                  ),
                ),
              for (var i = 0; i < ChallengeController.taskCount; i++)
                Card(
                  child: CheckboxListTile(
                    value: controller.isDone(i),
                    onChanged: (_) => controller.toggle(i),
                    secondary: Icon(_icons[i]),
                    title: Text(tasks[i]),
                    subtitle: Text(t.challengeDay(i + 1)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // Hỏi xác nhận rồi xóa tiến độ
  Future<void> _confirmReset(BuildContext context, AppLocalizations t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.challengeResetTitle),
        content: Text(t.challengeResetMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.detailCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.challengeReset),
          ),
        ],
      ),
    );
    if (ok == true) controller.reset();
  }
}