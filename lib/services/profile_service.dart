import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/goal.dart';
import 'package:user_side_final_project/models/profile.dart';

final profileServiceProvider = Provider((ref) => ProfileService());

class ProfileService {
  Future<List> fetchGoals() async {
    try {
      var response = await BaseClient().get("/goals");
      return response['data'].map((data) => Goal.fromJson(data)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      var response = await BaseClient()
          .put("/profile/${profile.id.toString()}", profile.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
