import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/element_model.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupDataModel extends ElementDataModel {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'entries')
  List<String> entryIds;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'owner')
  String ownerId;

  GroupDataModel({
    @required String id,
    this.name,
    this.type,
    this.entryIds,
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

  factory GroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataModelToJson(this);

  @override
  String toString() =>
      '$GroupDataModel { id: $id, name: $name, type: $type, entryIds: $entryIds, owner: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
