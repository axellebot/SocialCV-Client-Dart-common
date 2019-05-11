// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEnvelop<T> _$ResponseEnvelopFromJson<T>(Map<String, dynamic> json) {
  return ResponseEnvelop<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : _dataFromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ResponseEnvelopToJson<T>(ResponseEnvelop<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data == null ? null : _dataToJson(instance.data)
    };

ResponseEnvelopWithArray<T> _$ResponseEnvelopWithArrayFromJson<T>(
    Map<String, dynamic> json) {
  return ResponseEnvelopWithArray<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map(
              (e) => e == null ? null : _ResponseDataConverter<T>().fromJson(e))
          ?.toList())
    ..total = json['total'] as int;
}

Map<String, dynamic> _$ResponseEnvelopWithArrayToJson<T>(
        ResponseEnvelopWithArray<T> instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
          ?.map((e) => e == null ? null : _ResponseDataConverter<T>().toJson(e))
          ?.toList(),
      'total': instance.total
    };

RequestEnvelopOAuthAccessToken _$RequestEnvelopOAuthAccessTokenFromJson(
    Map<String, dynamic> json) {
  return RequestEnvelopOAuthAccessToken(
      username: json['username'] as String,
      password: json['password'] as String);
}

Map<String, dynamic> _$RequestEnvelopOAuthAccessTokenToJson(
        RequestEnvelopOAuthAccessToken instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password
    };

ResponseEnvelopOAuthAccessToken _$ResponseEnvelopOAuthAccessTokenFromJson(
    Map<String, dynamic> json) {
  return ResponseEnvelopOAuthAccessToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      accessTokenExpiresAt: json['expires_in'] as int,
      tokenType: json['token_type'] as String);
}

Map<String, dynamic> _$ResponseEnvelopOAuthAccessTokenToJson(
        ResponseEnvelopOAuthAccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.accessTokenExpiresAt,
      'token_type': instance.tokenType
    };
