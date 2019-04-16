import 'package:json_annotation/json_annotation.dart';
part 'base_data_model.g.dart';

@JsonSerializable()
class BaseDataModel extends Object {
  BaseDataModel({this.id}) : super();

  @JsonKey(name: '_id')
  String id;

  DateTime createdAt;
  DateTime updatedAt;

  @JsonKey(name: '__v')
  int v;

  factory BaseDataModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDataModelToJson(this);
}
