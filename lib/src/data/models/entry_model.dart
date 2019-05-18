import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/element_model.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryDataModel extends ElementDataModel {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'content')
  dynamic content;
  @JsonKey(name: 'startDate')
  String startDate;
  @JsonKey(name: 'endDate')
  String endDate;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'owner')
  String ownerId;

  EntryDataModel({
    @required String id,
    this.name,
    this.type,
    this.content,
    this.startDate,
    this.endDate,
    this.location,
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

  factory EntryDataModel.fromJson(Map<String, dynamic> json) =>
      _$EntryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryDataModelToJson(this);

  @override
  String toString() =>
      '$runtimeType{ id: $id, name: $name, type: $type, content: $content, startDate: $startDate, endDate: $endDate, location: $location, owner: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
