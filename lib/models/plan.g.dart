// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: json['id'] as int,
      currentSession: json['current_session'] as int,
      currentPhase: json['current_phase'] as int,
      challenge: Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'current_session': instance.currentSession,
      'current_phase': instance.currentPhase,
      'challenge': instance.challenge.toJson(),
    };
