// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDataModel _$BaseDataModelFromJson(Map<String, dynamic> json) {
  return BaseDataModel(id: json['_id'] as String)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String)
    ..v = json['__v'] as int;
}

Map<String, dynamic> _$BaseDataModelToJson(BaseDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v
    };
