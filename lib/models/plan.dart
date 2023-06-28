import 'package:json_annotation/json_annotation.dart';

import 'challenge.dart';

part 'plan.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Plan {
  int id;
  int currentSession;
  int currentPhase;
  Challenge challenge;
  

  Plan({required this.id,required this.currentSession, required this.currentPhase, required this.challenge});

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
