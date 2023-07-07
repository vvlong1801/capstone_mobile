// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionExercise _$SessionExerciseFromJson(Map<String, dynamic> json) =>
    SessionExercise(
      name: json['name'] as String?,
      image: json['image'] == null
          ? null
          : Media.fromJson(json['image'] as Map<String, dynamic>),
      order: json['order'] as int?,
      exerciseId: json['exercise_id'] as int,
      data: Exercise.fromJson(json['data'] as Map<String, dynamic>),
      requirement: json['requirement'] as String?,
      requirementUnit: json['requirement_unit'] as String?,
    );

Map<String, dynamic> _$SessionExerciseToJson(SessionExercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image?.toJson(),
      'order': instance.order,
      'requirement': instance.requirement,
      'requirement_unit': instance.requirementUnit,
      'exercise_id': instance.exerciseId,
      'data': instance.data.toJson(),
    };
