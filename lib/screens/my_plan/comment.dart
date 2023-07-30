import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/explore/controllers/comment_controller.dart';
import 'package:user_side_final_project/widgets/common/comment_widget.dart';

// ignore: must_be_immutable
class CommentPage extends ConsumerStatefulWidget {
  int challengeId;
  CommentPage({super.key, required this.challengeId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentPageState();
}

class _CommentPageState extends ConsumerState<CommentPage> {
  late AsyncValue comments;
  late TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    debugPrint("comment page");
    ref.read(commentProvider.notifier).getComments(widget.challengeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    comments = ref.watch(commentProvider);
    return comments.when(data: (data) {
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: listCommentWidget(data),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 94,
                    height: 60,
                    child: TextField(
                      controller: commentController,
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: "Enter comment",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 50,
                      color: Colors.deepPurple,
                      child: IconButton(
                          onPressed: () {
                            ref.read(commentProvider.notifier).sendComment(
                                widget.challengeId, commentController.text);
                            commentController.text = "";
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          )),
                    ),
                  )
                ]),
          ],
        ),
      );
    }, error: (error, _) {
      return Text(error.toString());
    }, loading: () {
      return const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      );
    });
  }

  List<Widget> listCommentWidget(List comments) {
    return comments
        .map((cmt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: CommentWidget(comment: cmt),
            ))
        .toList();
  }
}
