// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as int?,
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => SessionExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      order: json['order'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'exercises': instance.exercises?.map((e) => e.toJson()).toList(),
      'order': instance.order,
      'name': instance.name,
    };
