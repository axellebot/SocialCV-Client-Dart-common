// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartModel _$PartModelFromJson(Map<String, dynamic> json) {
  return PartModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      groupIds: (json['groups'] as List)?.map((e) => e as String)?.toList(),
      owner: json['owner'] as String)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String)
    ..v = json['__v'] as int
    ..profileId = json['profile'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$PartModelToJson(PartModel instance) => <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'name': instance.name,
      'groups': instance.groupIds,
      'owner': instance.owner,
      'profile': instance.profileId,
      'type': instance.type
    };
