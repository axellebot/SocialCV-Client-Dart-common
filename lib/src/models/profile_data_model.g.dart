// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDataModel _$ProfileDataModelFromJson(Map<String, dynamic> json) {
  return ProfileDataModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      picture: json['picture'] as String,
      cover: json['cover'] as String,
      type: json['type'] as String,
      parts: json['parts'],
      owner: json['owner'] as String)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String)
    ..v = json['__v'] as int;
}

Map<String, dynamic> _$ProfileDataModelToJson(ProfileDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picture': instance.picture,
      'cover': instance.cover,
      'type': instance.type,
      'parts': instance.parts,
      'owner': instance.owner
    };
