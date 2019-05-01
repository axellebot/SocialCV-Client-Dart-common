import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/models.dart';

/// Default Implementation of [CVApiManager]
class DefaultCVApiManager implements CVApiManager {
  final String _TAG = 'DefaultCVClient';

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
  Future<OAuthAccessTokenResponseModel> fetchToken({
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:fetchToken');

    OAuthAccessTokenRequestModel oauthModel = OAuthAccessTokenRequestModel(
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

    final OAuthAccessTokenResponseModel model =
        OAuthAccessTokenResponseModel.fromJson(response.data);
    return model;
  }

  ///
  /// Account
  ///

  @override
  Future<ResponseModel<UserDataModel>> fetchAccount() async {
    print('$_TAG:fetchAccount');

    Response response = await _dio.get(_pathMe);

    return ResponseModel<UserDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromAccount');

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

    return ResponseModelWithArray<ProfileDataModel>.fromJson(response.data);
  }

  ///
  /// Profiles
  ///

  @override
  Future<ResponseModel<ProfileDataModel>> fetchProfile(String profileId) async {
    print('$_TAG:fetchProfile($profileId)');

    String _path = _pathProfiles + '/$profileId';

    Response response = await _dio.get(_path);
    return ResponseModel<ProfileDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfiles');

    String _path = _pathProfiles;

    Response response = await _dio.get(_path, queryParameters: {
      'title': profileTitle,
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    switch (response.statusCode) {
      case HttpStatus.badRequest:
        throw ApiErrorWrongPaginationError();
      case HttpStatus.notFound:
        throw ApiErrorProfileNotFoundError();
    }

    return ResponseModelWithArray<ProfileDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromUser');

    // TODO: implement fetchProfilesFromUser
    String _path = _pathUsers + '/$userId' + _pathProfiles;
    throw NotImplementedYetError();
    //return null;
  }

  ///
  /// Parts
  ///

  @override
  Future<ResponseModel<PartDataModel>> fetchPart(String partId) async {
    print('$_TAG:fetchPart($partId)');

    Response response = await _dio.get(_pathParts + '/$partId');
    return ResponseModel<PartDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<PartDataModel>> fetchParts(
      {int offset = 0, int limit = 5}) async {
    print('$_TAG:fetchParts');

    String _path = _pathParts;

    // TODO: implement fetchParts
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<PartDataModel>> fetchPartsFromUser({
    String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchPartsFromUser($userId)');

    String _path = _pathUsers + '/$userId' + _pathParts;

    // TODO: implement fetchPartsFromUser
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchPartsFromProfile');

    String _path = _pathProfiles + '/$profileId' + _pathParts;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order'
    });

    return ResponseModelWithArray<PartDataModel>.fromJson(response.data);
  }

  ///
  /// Groups
  ///

  @override
  Future<ResponseModel<GroupDataModel>> fetchGroup(String groupId) async {
    print('$_TAG:fetchGroup($groupId)');

    String _path = _pathGroups + '/$groupId';

    Response response = await _dio.get(_path);
    return ResponseModel<GroupDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroups');

    // TODO: implement fetchGroups
    String _path = _pathGroups;
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<GroupDataModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroupsFromUser($userId)');

    // TODO: implement fetchGroupsFromUser
    String _path = _pathUsers + '/$userId' + _pathGroups;
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<GroupDataModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroupsFromPart($partId)');

    Response response =
        await _dio.get(_pathParts + '/$partId' + _pathGroups, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order',
    });
    return ResponseModelWithArray<GroupDataModel>.fromJson(response.data);
  }

  ///
  /// Entries
  ///

  @override
  Future<ResponseModel<EntryDataModel>> fetchEntry(String entryId) async {
    print('$_TAG:fetchEntry($entryId)');

    Response response = await _dio.get(_pathEntries + '/$entryId');
    return ResponseModel<EntryDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntries');
    // TODO: implement fetchEntries
    String _path = _pathEntries;
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<EntryDataModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    // TODO: implement fetchEntriesFromUser
    String _path = _pathUsers + '/$userId' + _pathEntries;
    throw NotImplementedYetError();
    //return null;
  }

  @override
  Future<ResponseModelWithArray<EntryDataModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntriesFromGroup($groupId)');

    String _path = _pathGroups + '/$groupId' + _pathEntries;

    Response response = await _dio.get(_path, queryParameters: {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sort': '+order',
    });
    return ResponseModelWithArray<EntryDataModel>.fromJson(response.data);
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
