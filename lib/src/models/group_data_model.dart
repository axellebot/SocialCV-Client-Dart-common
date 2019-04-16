import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

part 'group_data_model.g.dart';

@JsonSerializable()
class GroupDataModel extends BaseDataModel {
  GroupDataModel({
    String id,
    this.name,
    this.type,
    this.entryIds,
    this.owner,
  }) : super(id: id);

  String name;
  String type;
  @JsonKey(name: 'entries')
  List<String> entryIds;
  String owner;

  @JsonKey(name: 'profile')
  factory GroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataModelToJson(this);

  @override
  String toString() {
    return 'GroupDataModel{name: $name, type: $type, entryIds: $entryIds, owner: $owner}';
  }
}
