import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/challenge.dart';

final challengeServiceProvider =
    Provider<ChallengeService>((ref) => ChallengeService());

class ChallengeService {
  Future<List> fetchChallenges() async {
    try {
      var response = await BaseClient().get("/challenges");
      print(response['data']);
      return response['data']
          .map((challenge) => Challenge.fromJson(challenge))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List> fetchChallengeInvitations() async {
    try {
      var response = await BaseClient().get("/challenges/invitations");
      print(response['data']);
      return response['data']
          .map((challenge) => Challenge.fromJson(challenge))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Challenge> fetchChallengeById(int? id) async {
    try {
      var response = await BaseClient().get("/challenges/$id");

      return Challenge.fromJson(response['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> joinChallenge(int? id) async {
    try {
      var response = await BaseClient().get("/challenges/join/$id");
      return response["data"]['approved'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> acceptInvitation(int? challengeId) async {
    try {
      await BaseClient().get("/challenges/invitations/accept/$challengeId");
    } catch (e) {
      throw Exception(e);
    }
  }
}
