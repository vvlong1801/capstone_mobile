import 'package:json_annotation/json_annotation.dart';
part 'media.g.dart';

@JsonSerializable()
class Media {
  String filename;
  String path;
  String url;

  Media({required this.filename, required this.path, required this.url});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
