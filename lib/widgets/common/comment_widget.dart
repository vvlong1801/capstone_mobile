import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentWidget extends ConsumerWidget {
  final String username;

  final String content;

  final String? avatar;

  const CommentWidget(
      {super.key, required this.username, required this.content, this.avatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                color: Colors.orangeAccent,
                width: 40,
                height: 40,
                child: Center(child: Text("L")),
              )),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Long',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'good',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w300, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
