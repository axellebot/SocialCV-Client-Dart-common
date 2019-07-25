// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelop_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataEnvelop<T> _$DataEnvelopFromJson<T>(Map<String, dynamic> json) {
  return DataEnvelop<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : _GenericConverter<T>().fromJson(json['data']));
}

Map<String, dynamic> _$DataEnvelopToJson<T>(DataEnvelop<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data == null
          ? null
          : _GenericConverter<T>().toJson(instance.data)
    };

DataArrayEnvelop<T> _$DataArrayEnvelopFromJson<T>(Map<String, dynamic> json) {
  return DataArrayEnvelop<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null ? null : _GenericConverter<T>().fromJson(e))
          ?.toList(),
      total: json['total'] as int);
}

Map<String, dynamic> _$DataArrayEnvelopToJson<T>(
        DataArrayEnvelop<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
          ?.map((e) => e == null ? null : _GenericConverter<T>().toJson(e))
          ?.toList(),
      'total': instance.total
    };

RequestAuthDataModel _$RequestAuthDataModelFromJson(Map<String, dynamic> json) {
  return RequestAuthDataModel(
      username: json['username'] as String,
      password: json['password'] as String);
}

Map<String, dynamic> _$RequestAuthDataModelToJson(
        RequestAuthDataModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password
    };

ResponseAuthDataModel _$ResponseAuthDataModelFromJson(
    Map<String, dynamic> json) {
  return ResponseAuthDataModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      accessTokenExpiresIn: json['expires_in'] as int,
      tokenType: json['token_type'] as String)
    ..accessTokenExpiration = json['accessTokenExpiration'] == null
        ? null
        : DateTime.parse(json['accessTokenExpiration'] as String);
}

Map<String, dynamic> _$ResponseAuthDataModelToJson(
        ResponseAuthDataModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.accessTokenExpiresIn,
      'token_type': instance.tokenType,
      'accessTokenExpiration': instance.accessTokenExpiration?.toIso8601String()
    };
