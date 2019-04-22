import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

part 'entry_data_model.g.dart';

@JsonSerializable()
class EntryDataModel extends ElementDataModel {
  EntryDataModel({
    String id,
    this.name,
    this.startDate,
    this.endDate,
    this.location,
    this.owner,
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
  @JsonKey(name: 'content')
  dynamic content;
  @JsonKey(name: 'startDate')
  String startDate;
  @JsonKey(name: 'endDate')
  String endDate;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'owner')
  String owner;

  factory EntryDataModel.fromJson(Map<String, dynamic> json) =>
      _$EntryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryDataModelToJson(this);

  @override
  String toString() {
    return 'EntryDataModel { id: $id, name: $name, content: $content, startDate: $startDate, endDate: $endDate, location: $location, owner: $owner, type: $type}';
  }
}
