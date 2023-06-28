import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session_exercise.dart';

final workoutProvider =
    NotifierProvider<WorkoutNotifier, List<SessionExercise>>(
        WorkoutNotifier.new);

class WorkoutNotifier extends Notifier<List<SessionExercise>> {
  @override
  List<SessionExercise> build() {
    return [];
  }

  int currentIndex = 0;

  void initState(List<SessionExercise> exercises) {
    state = exercises;
  }

  SessionExercise getCurrentExercise() {
    return state[currentIndex];
  }

  String getNextRoute() {
    return state[currentIndex].requirementUnit == "reps"
        ? countStepRoute
        : countDownRoute;
  }

  bool checkCompleted() {
    return currentIndex + 1 == state.length;
  }

  String getProgress() {
    return "${(currentIndex + 1).toString()}/${state.length}";
  }

  void reset() {
    currentIndex = 0;
    state = [];
  }
}
