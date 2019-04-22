// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryDataModel _$EntryDataModelFromJson(Map<String, dynamic> json) {
  return EntryDataModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      location: json['location'] as String,
      owner: json['owner'] as String,
      type: json['type'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int)
    ..content = json['content'];
}

Map<String, dynamic> _$EntryDataModelToJson(EntryDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'name': instance.name,
      'content': instance.content,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'type': instance.type,
      'owner': instance.owner
    };
