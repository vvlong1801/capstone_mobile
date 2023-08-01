import 'package:json_annotation/json_annotation.dart';
import 'package:user_side_final_project/models/media.dart';
import 'package:user_side_final_project/models/tag.dart';
import 'package:user_side_final_project/models/user.dart';

part 'personal_trainer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PersonalTrainer {
    PersonalTrainer({
        required this.id,
        required this.user,
        required this.age,
        required this.youtube,
        required this.address,
        required this.facebook,
        required this.workoutTrainingMedia,
        required this.certificateIssuer,
        required this.workType,
        required this.techniques,
        required this.desiredSalary,
        required this.introduce,
        required this.gender,
        required this.zalo,
        required this.rate,
        required this.numRate,
        required this.members,
        required this.challenges,
        required this.verifiedAt,
    });

    final int? id;
    final User? user;
    final int? age;
    final String? youtube;
    final String? address;
    final String? facebook;
    final List<Media>? workoutTrainingMedia;
    final Tag? certificateIssuer;
    final String? workType;
    final List<Tag>? techniques;
    final int? desiredSalary;
    final String? introduce;
    final String? gender;
    final String? zalo;
    final int? rate;
    final int? numRate;
    final int? members;
    final int? challenges;
    final String? verifiedAt;

    factory PersonalTrainer.fromJson(Map<String, dynamic> json) => _$PersonalTrainerFromJson(json);

    Map<String, dynamic> toJson() => _$PersonalTrainerToJson(this);

}