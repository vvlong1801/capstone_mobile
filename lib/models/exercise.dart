import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/media.dart';
import 'package:user_side_final_project/models/tag.dart';
part 'exercise.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.level,
    required this.type,
    required this.createdBy,
    required this.groupTags,
    required this.requirementUnit,
    required this.requirementInitial,
    required this.description,
    required this.image,
    required this.gif,
    required this.youtubeUrl,
  });

  final int? id;
  final String? name;
  final String? level;
  final int? type;

  final String? createdBy;
  final List<Tag>? groupTags;
  final String? requirementUnit;
  final String? requirementInitial;
  final String? description;
  final Media? image;
  final Media? gif;
  final String? youtubeUrl;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
