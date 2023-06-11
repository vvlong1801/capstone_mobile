import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restTimerController = StateNotifierProvider<CountDownNotifier, int>(
    (ref) => CountDownNotifier(10));
final readyTimerController = StateNotifierProvider<CountDownNotifier, int>(
    (ref) => CountDownNotifier(10));

class CountDownNotifier extends StateNotifier<int> {
  Timer? _timer;

  late int _init;
  CountDownNotifier(this._init) : super(_init);
  int get init => _init;

  void run({BuildContext? context, Function? redirect}) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state > 0) {
        state = state - 1;
      } else if (context != null && redirect != null) {
        _timer!.cancel();
        redirect();
      }
    });
  }

  void add(int value) {
    _init += value;
    state += value;
  }

  void pause() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void reset() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    state = _init;
  }
}
