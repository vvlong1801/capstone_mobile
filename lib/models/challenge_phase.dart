import 'package:json_annotation/json_annotation.dart';

import 'session.dart';
part 'challenge_phase.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChallengePhase {
    ChallengePhase({
        required this.id,
        required this.name,
        required this.order,
        required this.level,
        required this.totalDays,
        required this.sessions,
    });

    final int? id;
    final dynamic name;
    final int? order;
    final bool? level;
    final int? totalDays;
    final List<Session>? sessions;

    factory ChallengePhase.fromJson(Map<String, dynamic> json) => _$ChallengePhaseFromJson(json);

    Map<String, dynamic> toJson() => _$ChallengePhaseToJson(this);


}
