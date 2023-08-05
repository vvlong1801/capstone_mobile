import 'package:collection/collection.dart';
import 'package:health/health.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_side_final_project/core/health/health_provider.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/models/workout_result.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/session_controller.dart';
import 'package:user_side_final_project/providers/workout/state/workout_state.dart';
import 'package:user_side_final_project/services/workout_service.dart';

class WorkoutNotifier extends Notifier<WorkoutState> {
  late DateTime? startTime;
  late DateTime? endTime;
  late double? calo = 0;
  late double? heartRate = 0;

  @override
  WorkoutState build() {
    return WorkoutState(listExercise: [], currentIndex: 0);
  }

  Duration get timeWorkout => endTime!.difference(startTime!);

  void increaseCurrentIndex() {
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void updateStartTime(DateTime time) {
    startTime = time;
  }

  void updateEndTime(DateTime time) {
    endTime = time;
  }

  void updateFeedback(String feedback) {
    state = state.copyWith(feedback: feedback);
  }

  void updateListExercise(List<SessionExercise> listExe) {
    state = state.copyWith(listExercise: listExe);
  }

  void reset() {
    state = state.copyWith(kcal: 0, heartRate: 0, currentIndex: 0);
  }

  String getProgress() {
    return "${(state.currentIndex + 1).toString()}/${state.listExercise.length}";
  }

  bool checkComplete() {
    return state.currentIndex + 1 == state.listExercise.length;
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
        calo = sumByDataType[HealthDataType.ACTIVE_ENERGY_BURNED] ?? null;
      }
      if (sumByDataType.containsKey(HealthDataType.HEART_RATE)) {
        heartRate = sumByDataType[HealthDataType.HEART_RATE] ?? null;
        // bpm = sumByDataType[HealthDataType.HEART_RATE]!;
      }
    }
  }

  void sendResult() {
    var duration = _formatDuration(timeWorkout);
    final planId = ref.watch(planIdProvider);
    final sessionId = ref.watch(sessionProvider).value!.id;

    WorkoutResult result = WorkoutResult(
        planId: planId,
        phaseSessionId: sessionId,
        duration: duration,
        caloriesBurned: calo ?? 0,
        bpm: heartRate ?? 0,
        feedback: state.feedback);
    ref.watch(workoutServiceProvider).postWorkoutResult(result);
    print("sended");
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
}

final workoutController =
    NotifierProvider<WorkoutNotifier, WorkoutState>(WorkoutNotifier.new);

final sendResult = FutureProvider((ref) {});
