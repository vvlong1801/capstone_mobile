import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/profile.dart';
import 'package:user_side_final_project/services/profile_service.dart';

class ProfileNotifier extends Notifier<Profile> {
  @override
  Profile build() {
    return Profile(
        id: 4,
        email: "long@gmail.com",
        gender: "male",
        age: 18,
        weight: 60,
        height: 170,
        goals: [],
        level: "beginner");
  }

  void setState(Profile profile) {
    state = profile;
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setWeight(int weight) {
    state = state.copyWith(weight: weight);
  }

  void setHeight(int height) {
    state = state.copyWith(height: height);
  }

  void setLevel(String level) {
    state = state.copyWith(level: level);
  }

  void setGoals(List goals) {
    state = state.copyWith(goals: goals);
  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void updateProfile() {
    ref.read(profileServiceProvider).updateProfile(state);
  }
}

final profileProvider =
    NotifierProvider<ProfileNotifier, Profile>(() => ProfileNotifier());

final listGoalData = FutureProvider<List>((ref) {
  return ref.read(profileServiceProvider).fetchGoals();
});
