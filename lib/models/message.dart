import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/user.dart';
part 'message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Message {
  Message({
    required this.id,
    required this.content,
    this.sender,
    this.receiver,
    this.replies,
  });

  final int? id;
  final String? content;
  final User? sender;
  final User? receiver;
  final List<Message>? replies;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
