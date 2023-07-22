import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/services/challenge_service.dart';

final listInvitationsProvider = FutureProvider<List>((ref) async {
  List invitations =
      await ref.watch(challengeServiceProvider).fetchChallengeInvitations();
  debugPrint("refesh");
  return invitations;
});
