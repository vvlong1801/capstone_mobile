import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/features/workout/presentation/state/countdown_state.dart';

import 'countdown_controller.dart';

final readyCountDownProvider = StateProvider<int>((ref) => 3);

final iconCountDownProvider = StateProvider<String>((ref) {
  CountDownState exerciseState = ref.watch(countdownExerciseController);
  return exerciseState.status == CountDownStatus.running ? "running" : "paused";
});
final countdownExerciseController =
    StateNotifierProvider<CountDownNotifier, CountDownState>((ref) {
  return CountDownNotifier(30);
});
