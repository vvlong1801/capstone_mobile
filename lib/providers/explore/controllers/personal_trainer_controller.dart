import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';
import 'package:user_side_final_project/services/creator_service.dart';

final listPersonalTrainerProvider =
    FutureProvider<List<PersonalTrainer>>((ref) async {
  return await ref.watch(creatorServiceProvider).fetchPersonalTrainers();
});

final detailPersonalTrainerProvider =
    Provider.family<PersonalTrainer?, int>((ref, id) {
  ref.watch(listPersonalTrainerProvider).whenData((data) {
    ref.state = data.firstWhere((pt) => pt.id == id);
  });
});
