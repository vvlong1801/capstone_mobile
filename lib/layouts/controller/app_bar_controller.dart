import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarNotifier extends Notifier<AppBarState> {
  @override
  AppBarState build() {
    return AppBarState(title: "");
  }

  void updateTitle(String value) {
    state.copyWith(title: value);
  }

  void addActionBeforePop(Function action) {
    state.copyWith(actionBeforePop: action);
  }
}

class AppBarState {
  late Function? actionBeforePop;
  late String title;

  AppBarState({required this.title, this.actionBeforePop});

  AppBarState copyWith({String? title, Function? actionBeforePop}) {
    return AppBarState(
        title: title ?? this.title, actionBeforePop: actionBeforePop);
  }
}

final appBarController = NotifierProvider<AppBarNotifier, AppBarState>(() {
  return AppBarNotifier();
});

