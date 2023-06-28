// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as int?,
      name: json['name'] as String?,
      level: json['level'] as String?,
      type: json['type'] as int?,
      createdBy: json['created_by'] as String?,
      groupTags: (json['group_tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      requirementUnit: json['requirement_unit'] as String?,
      requirementInitial: json['requirement_initial'] as String?,
      description: json['description'] as String?,
      image: json['image'] == null
          ? null
          : Media.fromJson(json['image'] as Map<String, dynamic>),
      gif: json['gif'] == null
          ? null
          : Media.fromJson(json['gif'] as Map<String, dynamic>),
      youtubeUrl: json['youtube_url'] as String?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'type': instance.type,
      'created_by': instance.createdBy,
      'group_tags': instance.groupTags?.map((e) => e.toJson()).toList(),
      'requirement_unit': instance.requirementUnit,
      'requirement_initial': instance.requirementInitial,
      'description': instance.description,
      'image': instance.image?.toJson(),
      'gif': instance.gif?.toJson(),
      'youtube_url': instance.youtubeUrl,
    };
