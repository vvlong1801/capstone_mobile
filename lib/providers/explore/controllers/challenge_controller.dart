import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';

final searchTextProvider = StateProvider<String>((ref) {
  return "";
});

final searchedChallenges = Provider<AsyncValue<List>>((ref) {
  final searchText = ref.watch(searchTextProvider);
  final challenges = ref.watch(exploreController);
  var result = challenges.whenData((data) {
    return data.where((challenge) {
      return challenge.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  });
  return result;
});

final listTags = [
  "easy",
  "middle",
  "hard",
  "Build muscle",
  "Cardio",
  "Balance & Stability",
  "HIIT",
  "Bodyweight",
  "Yoga"
];

final choosedTagsProvider = StateProvider((ref) {
  return [];
});

final filteredChallenges = Provider((ref) {
  final tags = ref.watch(choosedTagsProvider);
  final challenges = ref.watch(exploreController);
  final result = challenges.whenData((value) {
    return value.where((challenge) {
      var checkLevel = tags.contains(challenge.level);
      var checkTag = challenge.tags
          .where((challengeTag) => tags.contains(challengeTag.name))
          .toList();
      print(checkLevel);
      print(checkTag);
      return checkLevel || (checkTag.length > 0);
    }).toList();
  });
  return tags.isEmpty ? challenges : result;
});
