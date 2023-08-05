import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:user_side_final_project/core/health/health_service.dart';
import 'package:user_side_final_project/core/health/health_state.dart';

class HealthNotifier extends StateNotifier<HealthState> {
  late dynamic ref;
  HealthNotifier(this.ref)
      : super(HealthState(authorized: false, healthData: [])) {
    getData(types: [HealthDataType.ACTIVE_ENERGY_BURNED]);
  }

  void authorize() {
    ref
        .watch(healthServiceProvider)
        .authorize()
        .then((value) => {state = state.copyWith(authorized: value)});
    getData(types: [
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BASAL_ENERGY_BURNED,
      HealthDataType.HEART_RATE,
    ]);
  }

  void checkAuthorized() {
    ref.watch(healthServiceProvider).checkAuthorized().then((value) {
      print("permission: $value");
      state = state.copyWith(authorized: value);
    });
  }

  void unAuthorize() {
    ref.watch(healthServiceProvider).unAuthorize().then((value) {
      state = state.copyWith(authorized: false);
    });
  }

  List<HealthDataPoint> getData(
      {DateTime? start, DateTime? end, required List<HealthDataType> types}) {
    ref.read(healthServiceProvider).fetchData(dataTypes: types).then((value) {
      state = state.copyWith(healthData: value);
    });
    return state.healthData;
  }
}

final healthProvider = StateNotifierProvider<HealthNotifier, HealthState>(
    (ref) => HealthNotifier(ref));
