import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel extends ElementDataModel {
  ProfileDataModel({
    String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.type,
    this.parts,
    this.owner,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'subtitle')
  String subtitle;
  @JsonKey(name: 'picture')
  Uri picture;
  @JsonKey(name: 'cover')
  Uri cover;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'parts')
  dynamic parts;
  @JsonKey(name: 'owner')
  String owner;

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);

  @override
  String toString() =>
      'ProfileDataModel { id: $id, title: $title, subtitle: $subtitle, picture: $picture, cover: $cover, type: $type, parts: $parts, owner: $owner }';
}
