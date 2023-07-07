// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      filename: json['filename'] as String,
      path: json['path'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'filename': instance.filename,
      'path': instance.path,
      'url': instance.url,
    };
