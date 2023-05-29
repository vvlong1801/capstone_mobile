import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarController extends Notifier<String> {
  @override
  String build() {
    return "Home";
  }

  void updatePageTitle(String value) {
    state = value;
  }
}

