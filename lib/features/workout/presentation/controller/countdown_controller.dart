import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/features/workout/presentation/state/countdown_state.dart';

final restTimerController =
    StateNotifierProvider<CountDownNotifier, CountDownState>(
        (ref) => CountDownNotifier(10));
final readyTimerController =
    StateNotifierProvider<CountDownNotifier, CountDownState>(
        (ref) => CountDownNotifier(10));

class CountDownNotifier extends StateNotifier<CountDownState> {
  Timer? _timer;

  final int _init;
  late int startTime;

  CountDownNotifier(this._init)
      : startTime = _init,
        super(CountDownState(
            status: CountDownStatus.notStarted, currentTime: _init));

  void run() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.currentTime > 0) {
        state = state.copyWith(
            status: CountDownStatus.running,
            currentTime: state.currentTime - 1);
      } else {
        _timer!.cancel();
        state = state.copyWith(status: CountDownStatus.finised);
      }
    });
  }

  void addSeconds(int value) {
    startTime = state.currentTime + value;
    state = state.copyWith(currentTime: startTime);
  }

  void pause() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    state = state.copyWith(status: CountDownStatus.paused);
  }

  void restart() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    startTime = _init;
    state =
        state.copyWith(status: CountDownStatus.notStarted, currentTime: _init);
  }
}
