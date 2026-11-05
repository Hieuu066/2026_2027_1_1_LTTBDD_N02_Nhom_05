import 'package:flutter/foundation.dart';

// Lưu tiến độ thử thách 7 ngày (lưu tạm trong biến, tắt app sẽ mất)
class ChallengeController extends ChangeNotifier {
  static const int taskCount = 7;

  final List<bool> _done = List<bool>.filled(taskCount, false);

  bool isDone(int index) => _done[index];

  int get doneCount => _done.where((d) => d).length;

  bool get isCompleted => doneCount == taskCount;

  // Bấm một lần là hoàn thành, bấm lần nữa là bỏ hoàn thành
  void toggle(int index) {
    _done[index] = !_done[index];
    notifyListeners();
  }

  void reset() {
    _done.fillRange(0, taskCount, false);
    notifyListeners();
  }
}