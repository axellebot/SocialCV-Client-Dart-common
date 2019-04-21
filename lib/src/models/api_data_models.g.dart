// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(Map<String, dynamic> json) {
  return ResponseModel<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : _dataFromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ResponseModelToJson<T>(ResponseModel<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data == null ? null : _dataToJson(instance.data)
    };

ResponseModelWithArray<T> _$ResponseModelWithArrayFromJson<T>(
    Map<String, dynamic> json) {
  return ResponseModelWithArray<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map(
              (e) => e == null ? null : _ResponseDataConverter<T>().fromJson(e))
          ?.toList())
    ..total = json['total'] as int;
}

Map<String, dynamic> _$ResponseModelWithArrayToJson<T>(
        ResponseModelWithArray<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
          ?.map((e) => e == null ? null : _ResponseDataConverter<T>().toJson(e))
          ?.toList(),
      'total': instance.total
    };

OAuthTokenModel _$OAuthTokenModelFromJson(Map<String, dynamic> json) {
  return OAuthTokenModel(
      username: json['username'] as String,
      password: json['password'] as String);
}

Map<String, dynamic> _$OAuthTokenModelToJson(OAuthTokenModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password
    };

OAuthAccessTokenResponseModel _$OAuthAccessTokenResponseModelFromJson(
    Map<String, dynamic> json) {
  return OAuthAccessTokenResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      accessTokenExpiresAt: json['expires_in'] as int,
      tokenType: json['token_type'] as String);
}

Map<String, dynamic> _$OAuthAccessTokenResponseModelToJson(
        OAuthAccessTokenResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.accessTokenExpiresAt,
      'token_type': instance.tokenType
    };
