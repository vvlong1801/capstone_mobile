// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_phase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengePhase _$ChallengePhaseFromJson(Map<String, dynamic> json) =>
    ChallengePhase(
      id: json['id'] as int?,
      name: json['name'],
      order: json['order'] as int?,
      level: json['level'] as bool?,
      totalDays: json['total_days'] as int?,
      sessions: (json['sessions'] as List<dynamic>?)
          ?.map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChallengePhaseToJson(ChallengePhase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'level': instance.level,
      'total_days': instance.totalDays,
      'sessions': instance.sessions?.map((e) => e.toJson()).toList(),
    };
