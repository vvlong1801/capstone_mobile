import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/notifications/local_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().intialize();
  tz.initializeTimeZones();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}
