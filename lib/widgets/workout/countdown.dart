import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/workout/controller/countdown_controller.dart';
import 'package:user_side_final_project/providers/workout/state/countdown_state.dart';

class CountDown extends ConsumerStatefulWidget {
  final StateNotifierProvider<CountDownNotifier, CountDownState> controller;
  final Widget Function(BuildContext, int) build;

  final Function? onFinished;

  const CountDown(
      {super.key,
      required this.build,
      required this.controller,
      this.onFinished});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountDownState();
}

class _CountDownState extends ConsumerState<CountDown> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(widget.controller);
    ref.listen(widget.controller, (previous, next) {
      if (next.status == CountDownStatus.finised && widget.onFinished != null) {
        widget.onFinished!.call();
      }
    });
    return widget.build(context, provider.currentTime);
  }
}
