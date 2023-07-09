// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutResult _$WorkoutResultFromJson(Map<String, dynamic> json) =>
    WorkoutResult(
      planId: json['plan_id'] as int?,
      phaseSessionId: json['phase_session_id'] as int?,
      duration: json['duration'] as String?,
      caloriesBurned: (json['calories_burned'] as num?)?.toDouble(),
      bpm: (json['bpm'] as num?)?.toDouble(),
      video: json['video'] == null
          ? null
          : Media.fromJson(json['video'] as Map<String, dynamic>),
      feedback: json['feedback'] as String?,
      notifyCreator: json['notify_creator'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkoutResultToJson(WorkoutResult instance) =>
    <String, dynamic>{
      'plan_id': instance.planId,
      'phase_session_id': instance.phaseSessionId,
      'duration': instance.duration,
      'calories_burned': instance.caloriesBurned,
      'bpm': instance.bpm,
      'video': instance.video?.toJson(),
      'notify_creator': instance.notifyCreator,
      'feedback': instance.feedback,
    };
