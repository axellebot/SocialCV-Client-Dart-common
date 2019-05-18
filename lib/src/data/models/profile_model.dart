import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/element_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileDataModel extends ElementDataModel {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'subtitle')
  String subtitle;
  @JsonKey(name: 'picture')
  Uri picture;
  @JsonKey(name: 'cover')
  Uri cover;
  @JsonKey(name: 'parts')
  dynamic partIds;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'owner')
  String ownerId;

  ProfileDataModel({
    @required String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.partIds,
    this.type,
    this.ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);

  @override
  String toString() =>
      '$runtimeType{ id: $id, title: $title, subtitle: $subtitle, picture: $picture, cover: $cover, parts: $partIds, type: $type, owner: $ownerId }';
}
