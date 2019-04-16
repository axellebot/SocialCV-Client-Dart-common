import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

part 'part_data_model.g.dart';

@JsonSerializable()
class PartDataModel extends BaseDataModel {
  PartDataModel({
    String id,
    this.name,
    this.groupIds,
    this.owner,
  }) : super(id: id);

  String name;
  @JsonKey(name: 'groups')
  List<String> groupIds;
  String owner;
  @JsonKey(name: 'profile')
  String profileId;
  String type;

  factory PartDataModel.fromJson(Map<String, dynamic> json) =>
      _$PartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartDataModelToJson(this);

  @override
  String toString() {
    return 'PartDataModel{name: $name, groupIds: $groupIds, owner: $owner, profileId: $profileId, type: $type}';
  }
}
