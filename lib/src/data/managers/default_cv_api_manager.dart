import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/models.dart';

/// Default Implementation of [CVApiManager]
class DefaultCVApiManager implements CVApiManager {
  final String _tag = '$DefaultCVApiManager';

  final String apiBaseUrl;

  Dio _dio;

  static final String _pathOauth = '/oauth';
  static final String _pathOauthToken = _pathOauth + '/token';

  static final String _pathMe = '/me';
  static final String _pathUsers = '/users';
  static final String _pathProfiles = '/profiles';
  static final String _pathParts = '/parts';
  static final String _pathGroups = '/groups';
  static final String _pathEntries = '/entries';

  // TODO : Add Interceptor for token
  ApiInterceptor apiInterceptor;

  DefaultCVApiManager({
    @required this.apiBaseUrl,
    @required this.apiInterceptor,
  })  : assert(apiBaseUrl != null, 'Missing api base url'),
        assert(apiInterceptor != null, 'Missing api interceptor') {
    _dio = Dio(BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 3000,
      contentType: ContentType.json,
      responseType: ResponseType.json,
    ));

    /// Add Interceptor
    _dio.interceptors.add(apiInterceptor.interceptorsWrapper);
  }

  ///
  /// OAuth
  ///
  @override
  Future<ResponseEnvelopOAuthAccessToken> fetchToken({
    @required String email,
    @required String password,
  }) async {
    print('$_tag:$fetchToken');

    RequestEnvelopOAuthAccessToken oauthModel = RequestEnvelopOAuthAccessToken(
      username: email,
      password: password,
    );

    Response response =
        await _dio.post(_pathOauthToken, data: oauthModel.toJson());

    switch (response.statusCode) {
      case HttpStatus.badRequest:
        throw ApiErrorWrongPasswordError();
      case HttpStatus.notFound:
        throw ApiErrorUserNotFoundError();
    }

    final ResponseEnvelopOAuthAccessToken model =
        ResponseEnvelopOAuthAccessToken.fromJson(response.data);
    return model;
  }

  ///
  /// Account
  ///

  @override
  Future<ResponseEnvelop<UserDataModel>> fetchAccount() async {
    print('$_tag:$fetchAccount');

    Response response = await _dio.get(_pathMe);

    return ResponseEnvelop<UserDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchProfilesFromAccount');

    String _path = _pathMe + _pathProfiles;

    Response response = await _dio.get(
      _path,
      queryParameters: {
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );

    switch (response.statusCode) {
      case HttpStatus.notFound:
        throw BaseError('Profiles from account not found');
    }

    return ResponseEnvelopWithArray<ProfileDataModel>.fromJson(response.data);
  }

  ///
  /// Users
  ///

  @override
  Future<ResponseEnvelop<UserDataModel>> fetchUser(String userId) async {
    print('$_tag:$fetchUser($userId)');

    String _path = _pathUsers + '/$userId';

    Response response = await _dio.get(_path);
    return ResponseEnvelop<UserDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<UserDataModel>> fetchUsers({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchUsers');

    String _path = _pathUsers;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    switch (response.statusCode) {
      case HttpStatus.badRequest:
        throw ApiErrorWrongPaginationError();
      case HttpStatus.notFound:
        throw ApiErrorUserNotFoundError();
    }

    return ResponseEnvelopWithArray<UserDataModel>.fromJson(response.data);
  }

  ///
  /// Profiles
  ///

  @override
  Future<ResponseEnvelop<ProfileDataModel>> fetchProfile(
      String profileId) async {
    print('$_tag:$fetchProfile($profileId)');

    String _path = _pathProfiles + '/$profileId';

    Response response = await _dio.get(_path);
    return ResponseEnvelop<ProfileDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfiles({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchProfiles');

    String _path = _pathProfiles;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    switch (response.statusCode) {
      case HttpStatus.badRequest:
        throw ApiErrorWrongPaginationError();
      case HttpStatus.notFound:
        throw ApiErrorProfileNotFoundError();
    }

    return ResponseEnvelopWithArray<ProfileDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchProfilesFromUser');

    String _path = _pathUsers + '/$userId' + _pathProfiles;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<ProfileDataModel>.fromJson(response.data);
  }

  ///
  /// Parts
  ///

  @override
  Future<ResponseEnvelop<PartDataModel>> fetchPart(String partId) async {
    print('$_tag:$fetchPart($partId)');

    Response response = await _dio.get(_pathParts + '/$partId');
    return ResponseEnvelop<PartDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<PartDataModel>> fetchParts(
      {int offset = 0, int limit = 5}) async {
    print('$_tag:$fetchParts');

    String _path = _pathParts;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<PartDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<PartDataModel>> fetchPartsFromUser({
    String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchPartsFromUser($userId)');

    String _path = _pathUsers + '/$userId' + _pathParts;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<PartDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchPartsFromProfile');

    String _path = _pathProfiles + '/$profileId' + _pathParts;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order'
    });

    return ResponseEnvelopWithArray<PartDataModel>.fromJson(response.data);
  }

  ///
  /// Groups
  ///

  @override
  Future<ResponseEnvelop<GroupDataModel>> fetchGroup(String groupId) async {
    print('$_tag:$fetchGroup($groupId)');

    String _path = _pathGroups + '/$groupId';

    Response response = await _dio.get(_path);
    return ResponseEnvelop<GroupDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchGroups');

    String _path = _pathGroups;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<GroupDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchGroupsFromUser($userId)');

    String _path = _pathUsers + '/$userId' + _pathGroups;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<GroupDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchGroupsFromPart($partId)');

    Response response =
        await _dio.get(_pathParts + '/$partId' + _pathGroups, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order',
    });
    return ResponseEnvelopWithArray<GroupDataModel>.fromJson(response.data);
  }

  ///
  /// Entries
  ///

  @override
  Future<ResponseEnvelop<EntryDataModel>> fetchEntry(String entryId) async {
    print('$_tag:$fetchEntry($entryId)');

    Response response = await _dio.get(_pathEntries + '/$entryId');
    return ResponseEnvelop<EntryDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchEntries');

    String _path = _pathEntries;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<EntryDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchEntriesFromUser');

    String _path = _pathUsers + '/$userId' + _pathEntries;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    return ResponseEnvelopWithArray<EntryDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_tag:$fetchEntriesFromGroup($groupId)');

    String _path = _pathGroups + '/$groupId' + _pathEntries;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order',
    });
    return ResponseEnvelopWithArray<EntryDataModel>.fromJson(response.data);
  }
}

Future _filterStatusCode(response) async {
  switch (response.statusCode) {
    case HttpStatus.notImplemented:
      throw HttpServerErrorNotImplementedError();
    case HttpStatus.badGateway:
      throw HttpServerErrorBadGatewayError();
    case HttpStatus.serviceUnavailable:
      throw HttpServerErrorServiceUnavailableError();
    case HttpStatus.gatewayTimeout:
      throw HttpServerErrorGatewayTimeoutError();
    case HttpStatus.httpVersionNotSupported:
      throw HttpServerErrorHttpVersionNotSupportedError();
  }
  return response;
}
