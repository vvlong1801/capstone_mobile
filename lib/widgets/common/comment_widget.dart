import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/message.dart';

class CommentWidget extends ConsumerWidget {
  final Message comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _sendedComment(context, comment),
        ...listReliesComment(context, comment.replies)
      ],
    );
  }

  Widget _sendedComment(BuildContext context, Message comment) {
    var avatarUrl =
        comment.sender!.avatar == null ? "" : comment.sender!.avatar!.url;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                avatarUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.orangeAccent,
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Text(
                            "${comment.sender?.name?.substring(0, 1).toUpperCase()}")),
                  );
                },
              )),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comment.sender?.name}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${comment.content}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w300, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 48,
        )
      ],
    );
  }

  List listReliesComment(BuildContext context, List<Message>? replies) {
    if (replies == null) {
      return [];
    } else {
      return replies
          .map((cmt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _repliedComment(context, cmt),
              ))
          .toList();
    }
  }

  Widget _repliedComment(BuildContext context, Message comment) {
    var avatarUrl =
        comment.sender!.avatar == null ? "" : comment.sender!.avatar!.url;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 48,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${comment.sender?.name}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${comment.content}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w300, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                avatarUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.orangeAccent,
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Text(
                            "${comment.sender?.name?.substring(0, 1).toUpperCase()}")),
                  );
                },
              )),
        ),
      ],
    );
  }
}
