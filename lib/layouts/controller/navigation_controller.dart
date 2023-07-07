import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationController extends Notifier<int> {
  @override
  int build() {
    return 2;
  }

  void updateCurrentIndex(int index) {
    state = index;
  }
}

final navigationProvider = NotifierProvider<NavigationController, int>(() {
  return NavigationController();
});
