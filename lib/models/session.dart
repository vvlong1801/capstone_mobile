import 'package:json_annotation/json_annotation.dart';

import 'session_exercise.dart';
part 'session.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)

class Session {
    Session({
        required this.id,
        required this.exercises,
        required this.order,
        required this.name,
    });

    final int? id;
    final List<SessionExercise>? exercises;
    final int? order;
    final String? name;

    factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

    Map<String, dynamic> toJson() => _$SessionToJson(this);


}
