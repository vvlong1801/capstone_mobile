import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/services/challenge_service.dart';
import 'package:user_side_final_project/services/plan_service.dart';

final getScheduleProvider = FutureProvider.family<List, int?>((ref, id) async {
  Future<List> schedule = ref.watch(planServiceProvider).fetchScheduleById(id);
  return schedule;
});

class PlanNotifier extends AsyncNotifier<List> {
  void fetchPlans() {
    ref.read(planServiceProvider).fetchPlans().then((value) {
      state = AsyncData(value);
    });
  }

  late int planId;
  late int sessionWorkoutIndex;
  late int totalSessions;
  late bool completedPlan;

  AsyncValue getPlanById(id) {
    planId = id;
    final result = state.whenData((value) {
      final plan = value.firstWhere((element) => element.id == id);
      totalSessions = int.parse(plan.challenge.totalSessions);
      completedPlan = plan.completed;
      print('total session: $totalSessions');
      print('completed: $completedPlan');
      return plan;
    });
    return result;
  }

  AsyncValue getSession(sessionIndex, phaseIndex) {
    var schedule = ref.watch(getScheduleProvider(planId));
    return schedule;
  }

  Future<void> postRate(int rate) async {
    await ref.read(challengeServiceProvider).postRate(planId, rate);
  }

  bool checkCompletePlan() =>
      sessionWorkoutIndex == totalSessions && !completedPlan;

  @override
  FutureOr<List> build() {
    return ref.watch(planServiceProvider).fetchPlans();
  }
}

final planController =
    AsyncNotifierProvider<PlanNotifier, List>(() => PlanNotifier());

final completedPlansProvider = StateProvider((ref) {
  final listPlans = ref.watch(planController);
  return listPlans
      .whenData((value) => value.where((plan) => plan.completed).toList());
});

final doingPlansProvider = StateProvider((ref) {
  final listPlans = ref.watch(planController);
  return listPlans.whenData((value) => value
      .where((plan) => !plan.completed && plan.id != value.first.id)
      .toList());
});

final firstPlanProvider = StateProvider((ref) {
  final listPlans = ref.watch(planController);
  return listPlans.whenData((value) => value.first);
});

final listFeedbackProvider = FutureProvider.family<List, int>((ref, planId) {
  final listFeedbacks = ref.watch(planServiceProvider).fetchFeedbacks(planId);
  return listFeedbacks;
});
