// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDataModel _$GroupDataModelFromJson(Map<String, dynamic> json) {
  return GroupDataModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      entryIds: (json['entries'] as List)?.map((e) => e as String)?.toList(),
      ownerId: json['owner'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int);
}

Map<String, dynamic> _$GroupDataModelToJson(GroupDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'name': instance.name,
      'entries': instance.entryIds,
      'type': instance.type,
      'owner': instance.ownerId
    };
