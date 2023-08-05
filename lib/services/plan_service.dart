import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/challenge_phase.dart';
import 'package:user_side_final_project/models/message.dart';
import 'package:user_side_final_project/models/plan.dart';

final planServiceProvider = Provider<PlanService>((ref) => PlanService());

class PlanService {
  Future<List<Plan>> fetchPlans() async {
    try {
      var response = await BaseClient().get("/plans");
      return response['data']
          .map<Plan>((challenge) => Plan.fromJson(challenge))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ChallengePhase>> fetchScheduleById(int? id) async {
    try {
      var response = await BaseClient().get("/plans/$id/schedule");
      // print(response["data"]);
      return response["data"]
          .map<ChallengePhase>((phase) => ChallengePhase.fromJson(phase))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List> fetchFeedbacks(int? id) async {
    try {
      var response = await BaseClient().get("/plans/$id/feedback");
      return response["data"].map((fb) => Message.fromJson(fb)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
