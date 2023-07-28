import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

final healthServiceProvider = Provider((ref) => HealthService());

class HealthService {
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  // du lieu can lay
  static final types = [
    HealthDataType.WEIGHT,
    HealthDataType.STEPS,
    HealthDataType.HEIGHT,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.WORKOUT,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.BASAL_ENERGY_BURNED,
    // Uncomment these lines on iOS - only available on iOS
    // HealthDataType.AUDIOGRAM
  ];

  final permissions = types.map((e) => HealthDataAccess.READ).toList();

  Future authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have permission
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");
      }
    }
    return authorized;
  }

  Future<bool?> checkAuthorized() async {
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);
    print(hasPermissions);
    return hasPermissions;
  }

  Future unAuthorize() async {
    await health.revokePermissions();
  }

  Future fetchData(
      {DateTime? start,
      DateTime? end,
      required List<HealthDataType> dataTypes}) async {
    List<HealthDataPoint> healthData = [];

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 7));

    try {
      // fetch health data
      healthData =
          await health.getHealthDataFromTypes(yesterday, now, dataTypes);

      // filter out duplicates
      healthData = HealthFactory.removeDuplicates(healthData);
      print(healthData);
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }

    return healthData;
  }
}
