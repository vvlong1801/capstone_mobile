import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'countdown_controller.dart';

final readyCountDownProvider = StateProvider<int>((ref) => 3);
final iconCountDownProvider = StateProvider<String>((ref) => "running");
final countdownExerciseController =
    StateNotifierProvider<CountDownNotifier, int>((ref) {
  return CountDownNotifier(30);
});