import 'package:json_annotation/json_annotation.dart';

import 'media.dart';
import 'tag.dart';

part 'challenge.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Challenge {
  int id;
  String name;
  String? level;
  int? phasesCount;
  List<Tag> tags;
  Media? mainImage;

  String totalSessions;

  String? youtubeUrl;

  List<Media>? images;
  
  String? description;
  
  String? createdBy;

  Challenge(
      {required this.id,
      required this.name,
      required this.level,
      List<Tag>? tags,
      this.phasesCount,
      required this.totalSessions,
      this.mainImage,
      this.description,
      this.createdBy,
      this.youtubeUrl,
      this.images})
      : tags = tags ?? <Tag>[];

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
