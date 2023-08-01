import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';

final creatorServiceProvider =
    Provider<WorkoutService>((ref) => WorkoutService());

class WorkoutService {
  Future<List<PersonalTrainer>> fetchPersonalTrainers() async {
    try {
      var res = await BaseClient().get("/personal-trainers");

      return res["data"].map<PersonalTrainer>((pt) => PersonalTrainer.fromJson(pt)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
