import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/entry_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/group_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/part_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/profile_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/user_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class ResponseEnvelop<T> extends Object {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data', fromJson: _dataFromJson, toJson: _dataToJson)
  final T data;

  ResponseEnvelop({
    this.error,
    this.message,
    this.data,
  });

  factory ResponseEnvelop.fromJson(Map<String, dynamic> json) =>
      _$ResponseEnvelopFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseEnvelopToJson<T>(this);
}

// TODO : Add model if needed
T _dataFromJson<T>(Map<String, dynamic> input) {
  print('$_dataFromJson<$T>');

  if (T == UserDataModel)
    return UserDataModel.fromJson(input) as T;
  else if (T == ProfileDataModel)
    return ProfileDataModel.fromJson(input) as T;
  else if (T == PartDataModel)
    return PartDataModel.fromJson(input) as T;
  else if (T == GroupDataModel)
    return GroupDataModel.fromJson(input) as T;
  else if (T == EntryDataModel)
    return EntryDataModel.fromJson(input) as T;
  else
    throw Exception('Unknown type $T in ._dataFromJson');
}

// TODO : Add model if needed
Map<String, dynamic> _dataToJson<T>(Object json) {
  print('$_dataToJson<$T>');
  return json;
}

/// Model with GenericCollection https://github.com/dart-lang/json_serializable/blob/ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
@JsonSerializable()
class ResponseEnvelopWithArray<T> extends Object {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @_ResponseDataConverter()
  final List<T> data;

  ResponseEnvelopWithArray({
    this.error,
    this.message,
    this.data,
  });

  int total;

  factory ResponseEnvelopWithArray.fromJson(Map<String, dynamic> json) =>
      _$ResponseEnvelopWithArrayFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseEnvelopWithArrayToJson<T>(this);
}

class _ResponseDataConverter<T> implements JsonConverter<T, Object> {
  const _ResponseDataConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (T == UserDataModel)
        return UserDataModel.fromJson(json) as T;
      else if (T == ProfileDataModel)
        return ProfileDataModel.fromJson(json) as T;
      else if (T == PartDataModel)
        return PartDataModel.fromJson(json) as T;
      else if (T == GroupDataModel)
        return GroupDataModel.fromJson(json) as T;
      else if (T == EntryDataModel) return EntryDataModel.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}

@JsonSerializable()
class RequestEnvelopOAuthAccessToken extends Object {
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;

  RequestEnvelopOAuthAccessToken({
    @required this.username,
    @required this.password,
  })  : assert(username != null && password != null),
        super();

  factory RequestEnvelopOAuthAccessToken.fromJson(Map<String, dynamic> json) =>
      _$RequestEnvelopOAuthAccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEnvelopOAuthAccessTokenToJson(this);

  @override
  String toString() =>
      '$RequestEnvelopOAuthAccessToken { username: $username, password: HIDDEN }';
}

@JsonSerializable()
class ResponseEnvelopOAuthAccessToken extends Object {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'expires_in')
  final int accessTokenExpiresAt;
  @JsonKey(name: 'token_type')
  final String tokenType;

  ResponseEnvelopOAuthAccessToken({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiresAt,
    this.tokenType,
  }) : super();

  factory ResponseEnvelopOAuthAccessToken.fromJson(Map<String, dynamic> json) =>
      _$ResponseEnvelopOAuthAccessTokenFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ResponseEnvelopOAuthAccessTokenToJson(this);

  @override
  String toString() =>
      '$ResponseEnvelopOAuthAccessToken { accessToken: $accessToken, refreshToken: $refreshToken, accessTokenExpiresAt: $accessTokenExpiresAt, tokenType: $tokenType }';
}
