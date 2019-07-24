import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/domain.dart';

part 'envelop_models.g.dart';

/// ----------------------------------------------------------------------------
///                            Envelop
/// ----------------------------------------------------------------------------

abstract class _Envelop extends Object {
  @JsonKey(name: 'error')
  final bool error;

  @JsonKey(name: 'message')
  final String message;

  _Envelop({
    this.error,
    this.message,
  });
}

@JsonSerializable()
class DataEnvelop<T> extends _Envelop {
  @_GenericListConverter()
  T data;

  DataEnvelop({
    bool error,
    String message,
    this.data,
  }) : super(error: error, message: message);

  factory DataEnvelop.fromJson(Map<String, dynamic> json) =>
      _$DataEnvelopFromJson<T>(json);

  Map<String, dynamic> toJson() => _$DataEnvelopToJson<T>(this);
}

@JsonSerializable()
class DataArrayEnvelop<T> extends _Envelop {
  @_GenericListConverter()
  List<T> data;

  int total;

  DataArrayEnvelop({
    bool error,
    String message,
    this.data,
    this.total,
  }) : super(error: error, message: message);

  factory DataArrayEnvelop.fromJson(Map<String, dynamic> json) =>
      _$DataArrayEnvelopFromJson<T>(json);

  Map<String, dynamic> toJson() => _$DataArrayEnvelopToJson<T>(this);
}

/// Example of model with GenericCollection
/// https://github.com/dart-lang/json_serializable/blob/ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
class _GenericListConverter<T> implements JsonConverter<T, Object> {
  const _GenericListConverter();

  @override
  T fromJson(Object json) {
    print('fromJson');
    final T t = (T as dynamic)?.fromJson(json) as T
        // This will only work if `json` is a native JSON type:
        //   num, String, bool, null, etc
        // *and* is assignable to `T`.
        ??
        json as T;

    if (t == null) {
      throw Exception('Type $T no supported');
    }
    return t;
  }

  @override
  Object toJson(T object) {
    print('toJson');
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return (object as dynamic)?.toJson() ?? object;
  }
}

@JsonSerializable()
class RequestAuthDataModel extends Object {
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;

  RequestAuthDataModel({
    @required this.username,
    @required this.password,
  })  : assert(username != null && password != null),
        super();

  factory RequestAuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$RequestAuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestAuthDataModelToJson(this);

  @override
  String toString() => '$runtimeType{ '
      'username: $username, '
      'password: HIDDEN'
      ' }';
}

@JsonSerializable()
class ResponseAuthDataModel implements AuthEntity {
  @JsonKey(name: 'access_token')
  @override
  String accessToken;

  @JsonKey(name: 'refresh_token')
  @override
  String refreshToken;

  @JsonKey(name: 'expires_in')
  int accessTokenExpiresIn;

  @JsonKey(name: 'token_type')
  @override
  String tokenType;

  @override
  DateTime accessTokenExpiration;

  ResponseAuthDataModel({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiresIn,
    this.tokenType,
  }) : super() {
    accessTokenExpiration =
        DateTime.now().add(Duration(milliseconds: accessTokenExpiresIn));
  }

  factory ResponseAuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseAuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAuthDataModelToJson(this);

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'refreshToken: $refreshToken, '
      'accessTokenExpiresAt: $accessTokenExpiresIn, '
      'tokenType: $tokenType'
      ' }';
}
