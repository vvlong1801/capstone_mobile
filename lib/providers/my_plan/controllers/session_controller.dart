import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/challenge_phase.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/services/plan_service.dart';

final detailPlanProvider =
    FutureProvider.family<List<ChallengePhase>, int>((ref, planId) {
  return ref.watch(planServiceProvider).fetchScheduleById(planId);
});

final phaseIndexProvider = StateProvider((ref) => 0);
final sessionIndexProvider = StateProvider((ref) => 0);
final exerciseIndexProvider = StateProvider((ref) => 0);
final sessionId = StateProvider((ref) => 0);

final sessionProvider = Provider((ref) {
  final phaseIndex = ref.watch(phaseIndexProvider);
  final sessionIndex = ref.watch(sessionIndexProvider);
  final planId = ref.watch(planIdProvider);

  final session = ref
      .watch(detailPlanProvider(planId))
      .whenData((data) => data[phaseIndex].sessions![sessionIndex]);
  return session;
});

final sessionExerciseProvider = Provider((ref) {
  final exerciseIndex = ref.watch(exerciseIndexProvider);
  return ref
      .watch(sessionProvider)
      .whenData((session) => session.exercises![exerciseIndex]);
});
