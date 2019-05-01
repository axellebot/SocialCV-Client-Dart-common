import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/data/models/entry_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/group_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/part_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/profile_model.dart';
import 'package:social_cv_client_dart_common/src/data/models/user_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class ResponseModel<T> extends Object {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data', fromJson: _dataFromJson, toJson: _dataToJson)
  final T data;

  ResponseModel({
    this.error,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson<T>(this);
}

// TODO : Add model if needed
T _dataFromJson<T>(Map<String, dynamic> input) {
  print('_dataFromJson $T');

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
  print('_dataToJson $T');
  return json;
}

/// Model with GenericCollection https://github.com/dart-lang/json_serializable/blob/ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
@JsonSerializable()
class ResponseModelWithArray<T> extends Object {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'message')
  final String message;
  @_ResponseDataConverter()
  final List<T> data;

  ResponseModelWithArray({
    this.error,
    this.message,
    this.data,
  });

  int total;

  factory ResponseModelWithArray.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelWithArrayFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelWithArrayToJson<T>(this);
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
class OAuthAccessTokenRequestModel extends Object {
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;

  OAuthAccessTokenRequestModel({
    @required this.username,
    @required this.password,
  })  : assert(username != null && password != null),
        super();

  factory OAuthAccessTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OAuthAccessTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthAccessTokenRequestModelToJson(this);

  @override
  String toString() =>
      'OAuthAccessTokenRequestModel { username: $username, password: HIDDEN }';
}

@JsonSerializable()
class OAuthAccessTokenResponseModel extends Object {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'expires_in')
  final int accessTokenExpiresAt;
  @JsonKey(name: 'token_type')
  final String tokenType;

  OAuthAccessTokenResponseModel({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiresAt,
    this.tokenType,
  }) : super();

  factory OAuthAccessTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OAuthAccessTokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthAccessTokenResponseModelToJson(this);

  @override
  String toString() =>
      'OAuthAccessTokenResponseModel { accessToken: $accessToken, refreshToken: $refreshToken, accessTokenExpiresAt: $accessTokenExpiresAt, tokenType: $tokenType }';
}
