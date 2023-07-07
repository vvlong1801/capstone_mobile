import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/services/plan_service.dart';

// final listPlanProvider = FutureProvider<List>((ref) async {
//   Future<List> plans = ref.watch(planServiceProvider).fetchPlans();
//   return plans;
// });
final getScheduleProvider = FutureProvider.family<List, int?>((ref, id) async {
  Future<List> plan = ref.watch(planServiceProvider).fetchScheduleById(id);
  return plan;
});

class PlanNotifier extends AsyncNotifier<List> {
  Future<List> _fetchPlans() {
    Future<List> plans = ref.watch(planServiceProvider).fetchPlans();
    return plans;
  }

  late int planId;

  @override
  Future<List> build() {
    return _fetchPlans();
  }

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
    // var result = schedule.whenData((value) {
    //   print(value[phaseIndex].sessions[sessionIndex].exercises[0]);
    //   return value[phaseIndex].sessions[sessionIndex];
    // });
    return schedule;
  }
}

final planController =
    AsyncNotifierProvider<PlanNotifier, List>(() => PlanNotifier());
