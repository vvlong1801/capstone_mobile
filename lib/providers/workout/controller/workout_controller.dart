import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/models/workout_result.dart';
import 'package:user_side_final_project/services/workout_service.dart';

final workoutProvider =
    NotifierProvider<WorkoutNotifier, List<SessionExercise>>(
        WorkoutNotifier.new);

class WorkoutNotifier extends Notifier<List<SessionExercise>> {
  @override
  List<SessionExercise> build() {
    return [];
  }

  int currentIndex = 0;
  late int _planId;
  late int _phaseSessionId;
  late WorkoutResult result;
  late DateTime _startTime;
  late DateTime _finishTime;

  set startTime(DateTime startTime) => _startTime = startTime;
  set finishTime(DateTime finishTime) => _finishTime = finishTime;
  set planId(int planId) => _planId = planId;
  set phaseSessionId(int phaseSessionId) => _phaseSessionId = phaseSessionId;

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

  Duration? getTimeWorkout() {
    if (_startTime != null && _finishTime != null) {
      return _finishTime.difference(_startTime);
    }
    return null;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void sendResult() {
    var duration = _formatDuration(getTimeWorkout()!);
    debugPrint(duration);
    result = WorkoutResult(
        planId: _planId,
        phaseSessionId: _phaseSessionId,
        duration: duration,
        caloriesBurned: 22,
        bpm: 90);
    debugPrint(result.toString());
    ref.watch(workoutServiceProvider).postWorkoutResult(result);
  }
}
