// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryDataModel _$EntryDataModelFromJson(Map<String, dynamic> json) {
  return EntryDataModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      content: json['content'],
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      location: json['location'] as String,
      groupId: json['groupId'] as String,
      owner: json['owner'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int);
}

Map<String, dynamic> _$EntryDataModelToJson(EntryDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'name': instance.name,
      'type': instance.type,
      'content': instance.content,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'groupId': instance.groupId,
      'owner': instance.owner
    };
