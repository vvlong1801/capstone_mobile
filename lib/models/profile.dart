import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Profile {
  Profile({
    required this.id,
    this.name,
    required this.email,
    this.phoneNumber,
    this.gender = "male",
    this.age = 18,
    this.height = 170,
    this.weight = 65,
    this.bmi,
    this.level = "beginner",
    this.goals,
    this.firstLogin = 1,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final int? age;
  final int? height;
  final int? weight;
  final double? bmi;
  final String? level;
  final int? firstLogin;
  final List? goals;

  Profile copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    int? age,
    int? height,
    int? weight,
    double? bmi,
    String? level,
    List? goals,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      level: level ?? this.level,
      goals: goals ?? this.goals,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
