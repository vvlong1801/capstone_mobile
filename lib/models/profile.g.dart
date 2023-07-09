// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      gender: json['gender'] as String? ?? "male",
      age: json['age'] as int? ?? 18,
      height: json['height'] as int? ?? 170,
      weight: json['weight'] as int? ?? 65,
      bmi: (json['bmi'] as num?)?.toDouble(),
      level: json['level'] as String? ?? "beginner",
      goals: json['goals'] as List<dynamic>?,
      firstLogin: json['first_login'] as int? ?? 1,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'gender': instance.gender,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'bmi': instance.bmi,
      'level': instance.level,
      'first_login': instance.firstLogin,
      'goals': instance.goals,
    };
