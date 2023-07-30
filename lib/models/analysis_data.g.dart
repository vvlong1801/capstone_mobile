// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisData _$AnalysisDataFromJson(Map<String, dynamic> json) => AnalysisData(
      workoutDays: (json['workout_days'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      calInDay: (json['cal_in_day'] as List<dynamic>?)
          ?.map((e) => CalInDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeInDay: (json['time_in_day'] as List<dynamic>?)
          ?.map((e) => TimeInDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalTime: json['total_time'] as String?,
      sessionCount: json['session_count'] as int?,
      challengeCount: json['challenge_count'] as int?,
    );

Map<String, dynamic> _$AnalysisDataToJson(AnalysisData instance) =>
    <String, dynamic>{
      'workout_days':
          instance.workoutDays?.map((e) => e.toIso8601String()).toList(),
      'cal_in_day': instance.calInDay?.map((e) => e.toJson()).toList(),
      'time_in_day': instance.timeInDay?.map((e) => e.toJson()).toList(),
      'total_time': instance.totalTime,
      'session_count': instance.sessionCount,
      'challenge_count': instance.challengeCount,
    };

CalInDay _$CalInDayFromJson(Map<String, dynamic> json) => CalInDay(
      day: json['day'] as int?,
      calSum: json['cal_sum'] as int?,
    );

Map<String, dynamic> _$CalInDayToJson(CalInDay instance) => <String, dynamic>{
      'day': instance.day,
      'cal_sum': instance.calSum,
    };

TimeInDay _$TimeInDayFromJson(Map<String, dynamic> json) => TimeInDay(
      day: json['day'] as int?,
      totalDuration: json['total_duration'] as String?,
    );

Map<String, dynamic> _$TimeInDayToJson(TimeInDay instance) => <String, dynamic>{
      'day': instance.day,
      'total_duration': instance.totalDuration,
    };
