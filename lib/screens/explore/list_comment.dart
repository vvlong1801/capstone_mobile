import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/explore/controllers/comment_controller.dart';
import 'package:user_side_final_project/widgets/common/comment_widget.dart';

// ignore: must_be_immutable
class ListCommentPage extends ConsumerStatefulWidget {
  int challengeId;
  ListCommentPage({super.key, required this.challengeId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListCommentPageState();
}

class _ListCommentPageState extends ConsumerState<ListCommentPage> {
  late AsyncValue comments;

  @override
  void initState() {
    ref.read(commentProvider.notifier).getComments(widget.challengeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    comments = ref.watch(commentProvider);
    return comments.when(data: (data) {
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: listCommentWidget(data),
          ),
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
