import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/workout_result.dart';

final workoutServiceProvider =
    Provider<WorkoutService>((ref) => WorkoutService());

class WorkoutService {
  Future<void> postWorkoutResult(WorkoutResult result) async {
    try {
      await BaseClient().post("/workout/result", result.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
