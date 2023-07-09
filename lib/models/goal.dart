import 'package:json_annotation/json_annotation.dart';
part 'goal.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Goal {
    Goal({
        required this.id,
        required this.name,
    });

    final int? id;
    final String name;

    factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

    Map<String, dynamic> toJson() => _$GoalToJson(this);


}
