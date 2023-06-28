import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/media.dart';

import 'exercise.dart';
part 'session_exercise.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SessionExercise {
  SessionExercise({
    required this.name,
    required this.image,
    required this.order,
    required this.exerciseId,
    required this.data,
    required this.requirement,
    required this.requirementUnit,
  });

  final String? name;
  final Media? image;
  final int? order;
  final String? requirement;
  final String? requirementUnit;
  final int exerciseId;
  final Exercise data;

  factory SessionExercise.fromJson(Map<String, dynamic> json) =>
      _$SessionExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionExerciseToJson(this);
}
