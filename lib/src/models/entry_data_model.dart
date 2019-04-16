import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

part 'entry_data_model.g.dart';

@JsonSerializable()
class EntryDataModel extends BaseDataModel {
  EntryDataModel({
    String id,
    this.name,
    this.startDate,
    this.endDate,
    this.location,
    this.owner,
    this.type,
  }) : super(id: id);

  String name;
  dynamic content;
  String startDate;
  String endDate;
  String location;
  String owner;
  String type;

  factory EntryDataModel.fromJson(Map<String, dynamic> json) =>
      _$EntryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryDataModelToJson(this);

  @override
  String toString() {
    return 'EntryDataModel{name: $name, content: $content, startDate: $startDate, endDate: $endDate, location: $location, owner: $owner, type: $type}';
  }
}
