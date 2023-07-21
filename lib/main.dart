import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/notifications/local_notification.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().intialize();

  runApp(ProviderScope(
    child: MyApp(),
  ));
}
