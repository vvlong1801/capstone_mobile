// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalTrainer _$PersonalTrainerFromJson(Map<String, dynamic> json) =>
    PersonalTrainer(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      age: json['age'] as int?,
      youtube: json['youtube'] as String?,
      address: json['address'] as String?,
      facebook: json['facebook'] as String?,
      workoutTrainingMedia: (json['workout_training_media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificateIssuer: json['certificate_issuer'] == null
          ? null
          : Tag.fromJson(json['certificate_issuer'] as Map<String, dynamic>),
      workType: json['work_type'] as String?,
      techniques: (json['techniques'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      desiredSalary: json['desired_salary'] as int?,
      introduce: json['introduce'] as String?,
      gender: json['gender'] as String?,
      zalo: json['zalo'] as String?,
      rate: json['rate'] as int?,
      numRate: json['num_rate'] as int?,
      members: json['members'] as int?,
      challenges: json['challenges'] as int?,
      verifiedAt: json['verified_at'] as String?,
    );

Map<String, dynamic> _$PersonalTrainerToJson(PersonalTrainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'age': instance.age,
      'youtube': instance.youtube,
      'address': instance.address,
      'facebook': instance.facebook,
      'workout_training_media':
          instance.workoutTrainingMedia?.map((e) => e.toJson()).toList(),
      'certificate_issuer': instance.certificateIssuer?.toJson(),
      'work_type': instance.workType,
      'techniques': instance.techniques?.map((e) => e.toJson()).toList(),
      'desired_salary': instance.desiredSalary,
      'introduce': instance.introduce,
      'gender': instance.gender,
      'zalo': instance.zalo,
      'rate': instance.rate,
      'num_rate': instance.numRate,
      'members': instance.members,
      'challenges': instance.challenges,
      'verified_at': instance.verifiedAt,
    };
