import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/challenge.dart';
import 'package:user_side_final_project/services/challenge_service.dart';

final getChallengesProvider = FutureProvider<List>((ref) async {
  final api = ref.watch(challengeServiceProvider);
  return api.fetchChallenges();
});

final showChallengeProvider =
    FutureProvider.family<Challenge, int?>((ref, id) async {
  Future<Challenge> challenge =
      ref.watch(challengeServiceProvider).fetchChallengeById(id);
  return challenge;
});

final joinChallengeProvider =
    FutureProvider.family<bool, int?>((ref, id) async {
  Future<bool> approved = ref.watch(challengeServiceProvider).joinChallenge(id);
  return approved;
});

final listComment = FutureProvider.family<List, int>((ref, challengeId) async {
  return ref.watch(challengeServiceProvider).fetchComments(challengeId);
});

class ExploreNotifier extends AsyncNotifier<List> {
  @override
  FutureOr<List> build() {
    return ref.watch(challengeServiceProvider).fetchChallenges();
  }

  void getChallenges() {
    ref.watch(challengeServiceProvider).fetchChallenges().then((value) {
      state = AsyncValue.data(value);
    });
  }
}

final exploreController =
    AsyncNotifierProvider<ExploreNotifier, List>(() => ExploreNotifier());
