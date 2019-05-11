import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

abstract class BaseDataModel extends Object {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: '__v')
  int version;

  BaseDataModel({
    @required this.id,
    this.createdAt,
    this.updatedAt,
    this.version,
  }) : super();

  @override
  String toString() =>
      '$BaseDataModel { id: $id, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
