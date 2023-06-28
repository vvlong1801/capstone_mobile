import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagWidget extends ConsumerWidget {
  final String text;

  const TagWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: const Color(0x32FFFFFF),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
