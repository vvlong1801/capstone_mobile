import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/plan.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/session_controller.dart';
import 'package:user_side_final_project/services/plan_service.dart';

// my plan screen
final listPlanProvider = FutureProvider<List<Plan>>((ref) async {
  return ref.watch(planServiceProvider).fetchPlans();
});

final completedPlansProvider = StateProvider((ref) {
  final listPlans = ref.watch(listPlanProvider);
  return listPlans
      .whenData((value) => value.where((plan) => plan.completed).toList());
});

final doingPlansProvider = StateProvider((ref) {
  final listPlans = ref.watch(listPlanProvider);
  return listPlans.whenData((value) => value
      .where((plan) => !plan.completed && plan.id != value.first.id)
      .toList());
});

final firstPlanProvider = StateProvider((ref) {
  final listPlans = ref.watch(listPlanProvider);
  return listPlans.whenData((value) => value.first);
});

final planIdProvider = StateProvider((ref) => 0);
// plan
final planProvider = Provider<AsyncValue>((ref) {
  final planId = ref.watch(planIdProvider);

  final plan = ref.watch(listPlanProvider).whenData((value) {
    return value.firstWhere((element) => element.id == planId);
  });

  return plan;
});

final completePlanProvider = Provider((ref) {
  final int sessionIndex = ref.watch(sessionIndexProvider);
  final Plan plan = ref.watch(planProvider).value!;
  final int totalSession = int.parse(plan.challenge.totalSessions);

  return (sessionIndex + 1) == totalSession && !plan.completed;
});
