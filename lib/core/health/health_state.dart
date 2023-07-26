import 'package:health/health.dart';

class HealthState {
  late bool authorized;
  late List<HealthDataPoint> healthData;

  HealthState({required this.authorized, required this.healthData});

  HealthState copyWith({bool? authorized, List<HealthDataPoint>? healthData}) {
    return HealthState(
        authorized: authorized ?? this.authorized,
        healthData: healthData ?? this.healthData);
  }
}
