import 'package:json_annotation/json_annotation.dart';

part 'analysis_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AnalysisData {
  AnalysisData({
    required this.workoutDays,
    required this.calInDay,
    required this.timeInDay,
    required this.totalTime,
    required this.sessionCount,
    required this.challengeCount,
  });

  final List<DateTime>? workoutDays;

  final List<CalInDay>? calInDay;

  final List<TimeInDay>? timeInDay;

  final String? totalTime;

  final int? sessionCount;

  final int? challengeCount;

  factory AnalysisData.fromJson(Map<String, dynamic> json) =>
      _$AnalysisDataFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CalInDay {
  CalInDay({
    required this.day,
    required this.calSum,
  });

  final int? day;
  final int? calSum;

  factory CalInDay.fromJson(Map<String, dynamic> json) =>
      _$CalInDayFromJson(json);

  Map<String, dynamic> toJson() => _$CalInDayToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TimeInDay {
  TimeInDay({
    required this.day,
    required this.totalDuration,
  });

  final int? day;
  final String? totalDuration;

  factory TimeInDay.fromJson(Map<String, dynamic> json) =>
      _$TimeInDayFromJson(json);

  Map<String, dynamic> toJson() => _$TimeInDayToJson(this);
}
