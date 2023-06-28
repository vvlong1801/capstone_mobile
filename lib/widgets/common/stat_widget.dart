import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class StatWidget extends ConsumerWidget {
  String? label;

  String? value;

  Widget? labelWidget;

  Widget? valueWidget;

  StatWidget(
      {super.key, this.label, this.value, this.labelWidget, this.valueWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
      alignment: Alignment.center,
      height: 100,
      color: Colors.deepPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          labelWidget ??
              Text(
                value!,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
          valueWidget ??
              Text(
                label!,
                style: const TextStyle(color: Colors.white),
              )
        ],
      ),
    );
  }
}

