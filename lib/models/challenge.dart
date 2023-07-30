import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/message.dart';

import 'media.dart';
import 'tag.dart';

part 'challenge.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Challenge {
  int id;
  String name;
  String? level;
  int? phasesCount;
  int? maxMembers;
  int? membersCount;
  double? rate;
  int? numRate;
  List<Tag> tags;
  Media? mainImage;

  String totalSessions;

  String? youtubeUrl;

  List<Media>? images;
  List<Message> comments;

  String? description;

  String? createdBy;

  Challenge(
      {required this.id,
      required this.name,
      required this.level,
      List<Tag>? tags,
      this.phasesCount,
      this.membersCount,
      this.maxMembers,
      this.rate,
      this.numRate,
      required this.totalSessions,
      this.mainImage,
      this.description,
      this.createdBy,
      this.youtubeUrl,
      required this.comments,
      this.images})
      : tags = tags ?? <Tag>[];

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
