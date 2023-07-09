import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/services/plan_service.dart';

final getPlansProvider = FutureProvider<List>((ref) async {
  Future<List> plans = ref.watch(planServiceProvider).fetchPlans();
  return plans;
});

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
  late int phaseSessionId;

  AsyncValue getPlanById(id) {
    planId = id;
    final result = state.whenData((value) {
      final plan = value.firstWhere((element) => element.id == id);
      return plan;
    });
    return result;
  }

  AsyncValue getSession(sessionIndex, phaseIndex) {
    var schedule = ref.watch(getScheduleProvider(planId));
    return schedule;
  }

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
