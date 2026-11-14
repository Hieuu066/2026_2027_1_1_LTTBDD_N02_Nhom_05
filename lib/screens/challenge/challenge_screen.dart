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
    final cs = Theme.of(context).colorScheme;
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
              // Khối đầu: lời giới thiệu và thanh tiến độ
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primary.withValues(alpha: 0.25),
                      cs.primaryContainer.withValues(alpha: 0.5),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.challengeIntro,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: controller.doneCount /
                                ChallengeController.taskCount,
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(6),
                            backgroundColor: cs.surface.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          t.challengeProgress(controller.doneCount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (controller.isCompleted)
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 16),
                  color: cs.tertiaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: const Text('🎉', style: TextStyle(fontSize: 28)),
                    title: Text(
                      t.challengeCongrats,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cs.onTertiaryContainer,
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < ChallengeController.taskCount; i++)
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: controller.isDone(i)
                      ? cs.primaryContainer.withValues(alpha: 0.6)
                      : cs.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: controller.isDone(i)
                          ? cs.primary.withValues(alpha: 0.5)
                          : cs.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: CheckboxListTile(
                    value: controller.isDone(i),
                    onChanged: (_) => controller.toggle(i),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    secondary: Icon(
                      _icons[i],
                      color: controller.isDone(i) ? cs.primary : cs.outline,
                    ),
                    title: Text(
                      tasks[i],
                      style: TextStyle(
                        decoration: controller.isDone(i)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
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