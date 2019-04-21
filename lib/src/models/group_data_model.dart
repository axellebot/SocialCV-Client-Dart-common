import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

part 'group_data_model.g.dart';

@JsonSerializable()
class GroupDataModel extends ElementDataModel {
  GroupDataModel({
    String id,
    this.name,
    this.type,
    this.entryIds,
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

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'entries')
  List<String> entryIds;
  @JsonKey(name: 'owner')
  String owner;

  factory GroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataModelToJson(this);

  @override
  String toString() {
    return 'GroupDataModel { id: $id, name: $name, type: $type, entryIds: $entryIds, owner: $owner}';
  }
}
