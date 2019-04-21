import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

part 'part_data_model.g.dart';

@JsonSerializable()
class PartDataModel extends ElementDataModel {
  PartDataModel({
    String id,
    this.name,
    this.groupIds,
    this.owner,
    this.profileId,
    this.type,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'groups')
  List<String> groupIds;
  @JsonKey(name: 'profile')
  String profileId;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'owner')
  String owner;

  factory PartDataModel.fromJson(Map<String, dynamic> json) =>
      _$PartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartDataModelToJson(this);

  @override
  String toString() {
    return 'PartDataModel{ id: $id, name: $name, groupIds: $groupIds, profileId: $profileId, type: $type, owner: $owner}';
  }
}
