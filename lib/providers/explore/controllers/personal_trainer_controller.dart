import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';
import 'package:user_side_final_project/services/creator_service.dart';

final listPersonalTrainerProvider =
    FutureProvider<List<PersonalTrainer>>((ref) async {
  return await ref.watch(creatorServiceProvider).fetchPersonalTrainers();
});

final personalTrainerIdProvider = StateProvider((ref) => 0);

final detailPersonalTrainerProvider = Provider((ref) {
  final ptId = ref.watch(personalTrainerIdProvider);
  return ref.watch(listPersonalTrainerProvider).whenData((data) {
    return data.firstWhere((pt) => pt.id == ptId);
  });
});
