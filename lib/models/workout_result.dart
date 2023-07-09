import 'package:json_annotation/json_annotation.dart';

import 'media.dart';

part 'workout_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WorkoutResult {
  WorkoutResult({
    required this.planId,
    required this.phaseSessionId,
    required this.duration,
    required this.caloriesBurned,
    required this.bpm,
    this.video,
    this.feedback,
    this.notifyCreator = false,
  });

  final int? planId;

  final int? phaseSessionId;
  final String? duration;

  final double? caloriesBurned;
  final double? bpm;
  final Media? video;

  final bool? notifyCreator;
  final String? feedback;

  factory WorkoutResult.fromJson(Map<String, dynamic> json) =>
      _$WorkoutResultFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutResultToJson(this);
}
