// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDataModel _$ProfileDataModelFromJson(Map<String, dynamic> json) {
  return ProfileDataModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      picture:
          json['picture'] == null ? null : Uri.parse(json['picture'] as String),
      cover: json['cover'] == null ? null : Uri.parse(json['cover'] as String),
      partIds: json['parts'],
      type: json['type'] as String,
      ownerId: json['owner'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int);
}

Map<String, dynamic> _$ProfileDataModelToJson(ProfileDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picture': instance.picture?.toString(),
      'cover': instance.cover?.toString(),
      'parts': instance.partIds,
      'type': instance.type,
      'owner': instance.ownerId
    };
