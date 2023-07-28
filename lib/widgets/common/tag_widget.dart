import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class TagWidget extends ConsumerWidget {
  final String text;
  Color? backgroundColor;
  Color? textColor;

  TagWidget(
      {super.key, required this.text, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: backgroundColor ?? const Color(0x32FFFFFF),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
