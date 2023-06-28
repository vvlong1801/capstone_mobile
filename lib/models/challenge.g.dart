// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
      id: json['id'] as int,
      name: json['name'] as String,
      level: json['level'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      phasesCount: json['phases_count'] as int?,
      totalSessions: json['total_sessions'] as String,
      mainImage: json['main_image'] == null
          ? null
          : Media.fromJson(json['main_image'] as Map<String, dynamic>),
      description: json['description'] as String?,
      createdBy: json['created_by'] as String?,
      youtubeUrl: json['youtube_url'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'phases_count': instance.phasesCount,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'main_image': instance.mainImage?.toJson(),
      'total_sessions': instance.totalSessions,
      'youtube_url': instance.youtubeUrl,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'created_by': instance.createdBy,
    };
