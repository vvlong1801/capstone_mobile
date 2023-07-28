import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/media.dart';
part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.phoneNumber,
        required this.avatar,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? role;
    final String? phoneNumber;
    final Media? avatar;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
