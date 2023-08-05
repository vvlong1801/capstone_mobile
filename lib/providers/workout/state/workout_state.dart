import 'package:user_side_final_project/models/session_exercise.dart';

class WorkoutState {
  final double? kcal;
  final double? heartRate;
  final List<SessionExercise> listExercise;
  final int currentIndex;
  final String? feedback;

  WorkoutState(
      {this.kcal,
      this.heartRate,
      required this.listExercise,
      required this.currentIndex,
      this.feedback});

  WorkoutState copyWith(
      {double? kcal,
      double? heartRate,
      List<SessionExercise>? listExercise,
      int? currentIndex,
      String? feedback = ""}) {
    return WorkoutState(
        kcal: kcal ?? this.kcal,
        heartRate: heartRate ?? this.heartRate,
        listExercise: listExercise ?? this.listExercise,
        currentIndex: currentIndex ?? this.currentIndex,
        feedback: feedback ?? this.feedback);
  }

  SessionExercise get currentExercise => listExercise[currentIndex];
  SessionExercise? get nextExercise {
    if (currentIndex + 1 == listExercise.length) {
      return null;
    } else {
      return listExercise[currentIndex + 1];
    }
  }
}
