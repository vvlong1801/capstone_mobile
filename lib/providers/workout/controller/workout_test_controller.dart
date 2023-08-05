import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:user_side_final_project/core/health/health_provider.dart';
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
  late DateTime startTime;
  late DateTime finishTime;
  double caloriesBurned = 0.0;
  double bpm = 0.0;
  String? feedback;

  set planId(int planId) => _planId = planId;
  set phaseSessionId(int phaseSessionId) => _phaseSessionId = phaseSessionId;

  void initState(List<SessionExercise> exercises) {
    state = exercises;
  }

  SessionExercise getCurrentExercise() {
    return state[currentIndex];
  }

  SessionExercise? getNextExercise() {
    if (currentIndex < state.length - 1) {
      return state[currentIndex + 1];
    } else {
      return null;
    }
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
    feedback = null;
  }

  Duration? getTimeWorkout() {
    if (startTime != null && finishTime != null) {
      return finishTime.difference(startTime);
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
        caloriesBurned: caloriesBurned,
        bpm: bpm,
        feedback: feedback);
    debugPrint(result.toString());
    ref.watch(workoutServiceProvider).postWorkoutResult(result);
  }

  void getWorkoutData() {
    if (ref.watch(healthProvider).authorized) {
      List<HealthDataPoint> healthData =
          ref.read(healthProvider.notifier).getData(types: [
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.BASAL_ENERGY_BURNED,
        HealthDataType.HEART_RATE,
      ]);

      Map<HealthDataType, List<HealthDataPoint>> groupedData =
          groupBy<HealthDataPoint, HealthDataType>(
              healthData, (HealthDataPoint dataPoint) => dataPoint.type);
      // Calculate sum of 'value' for each group
      Map<HealthDataType, double> sumByDataType = {};

      groupedData.forEach((dataType, dataPoints) {
        double sum = dataPoints
            .map((dataPoint) => double.parse(dataPoint.value.toString()))
            .fold(0.0, (previousValue, element) => previousValue + element);
        sumByDataType[dataType] = sum;
      });

      print(sumByDataType);

      if (sumByDataType.containsKey(HealthDataType.ACTIVE_ENERGY_BURNED)) {
        caloriesBurned = sumByDataType[HealthDataType.ACTIVE_ENERGY_BURNED]!;
      }
      if (sumByDataType.containsKey(HealthDataType.HEART_RATE)) {
        bpm = sumByDataType[HealthDataType.HEART_RATE]!;
      }
    }
  }
}
