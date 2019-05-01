import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/element_model.dart';

part 'part_model.g.dart';

@JsonSerializable()
class PartDataModel extends ElementDataModel {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'groups')
  List<String> groupIds;
  @JsonKey(name: 'profile')
  String profileId;
  @JsonKey(name: 'owner')
  String owner;

  PartDataModel({
    @required String id,
    this.name,
    this.type,
    this.groupIds,
    this.owner,
    this.profileId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  factory PartDataModel.fromJson(Map<String, dynamic> json) =>
      _$PartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartDataModelToJson(this);

  @override
  String toString() {
    return 'PartDataModel{ id: $id, name: $name, groupIds: $groupIds, profileId: $profileId, type: $type, owner: $owner}';
  }
}
