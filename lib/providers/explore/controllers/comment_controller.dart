import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/message.dart';
import 'package:user_side_final_project/models/user.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';
import 'package:user_side_final_project/services/challenge_service.dart';

class CommentNotifier extends AsyncNotifier<List> {
  @override
  FutureOr<List> build() {
    return [];
  }

  void getComments(int challengeId) {
    ref
        .watch(challengeServiceProvider)
        .fetchComments(challengeId)
        .then((value) => state = AsyncValue.data(value));
  }

  void sendComment(int challengeId, String content) async {
    final profile = ref.watch(profileProvider);
    Message message = Message(
        id: null,
        content: content,
        sender: User(
            id: profile.id,
            name: profile.name,
            email: profile.email,
            role: "member",
            phoneNumber: profile.phoneNumber,
            avatar: null));
    await ref.read(challengeServiceProvider).putComment(challengeId, content);
    state.whenData((value) {
      state = AsyncValue.data([message, ...value]);
    });
  }
}

final commentProvider =
    AsyncNotifierProvider<CommentNotifier, List>(CommentNotifier.new);
