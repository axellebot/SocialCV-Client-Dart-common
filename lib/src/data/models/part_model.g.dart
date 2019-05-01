// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartDataModel _$PartDataModelFromJson(Map<String, dynamic> json) {
  return PartDataModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      groupIds: (json['groups'] as List)?.map((e) => e as String)?.toList(),
      owner: json['owner'] as String,
      profileId: json['profile'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int);
}

Map<String, dynamic> _$PartDataModelToJson(PartDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'name': instance.name,
      'type': instance.type,
      'groups': instance.groupIds,
      'profile': instance.profileId,
      'owner': instance.owner
    };
