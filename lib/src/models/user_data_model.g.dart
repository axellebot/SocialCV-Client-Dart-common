// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  return UserDataModel(
      id: json['_id'] as String,
      disabled: json['disabled'] as bool,
      email: json['email'] as String,
      username: json['username'] as String,
      picture: json['picture'] as String,
      profileIds: (json['profiles'] as List)?.map((e) => e as String)?.toList(),
      permission: json['permission'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int);
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'disabled': instance.disabled,
      'email': instance.email,
      'username': instance.username,
      'picture': instance.picture,
      'profiles': instance.profileIds,
      'permission': instance.permission
    };
