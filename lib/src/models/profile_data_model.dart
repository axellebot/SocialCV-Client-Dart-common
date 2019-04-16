import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel extends BaseDataModel {
  ProfileDataModel({
    String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.type,
    this.parts,
    this.owner,
  }) : super(id: id);

  String title;
  String subtitle;
  String picture;
  String cover;
  String type;

  @JsonKey(name: 'parts')
  dynamic parts;

  String owner;

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);

  @override
  String toString() {
    return 'ProfileDataModel{title: $title, subtitle: $subtitle, picture: '
        '$picture, cover: $cover, type: $type, parts: $parts, owner: $owner}';
  }
}
