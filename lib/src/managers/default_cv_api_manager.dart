import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/errors/api_errors.dart';
import 'package:social_cv_client_dart_common/src/errors/app_error.dart';
import 'package:social_cv_client_dart_common/src/errors/base_errors.dart';
import 'package:social_cv_client_dart_common/src/errors/http_errors.dart';
import 'package:social_cv_client_dart_common/src/managers/api_interceptor.dart';
import 'package:social_cv_client_dart_common/src/managers/cv_api_manager.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

/// Default Implementation of [CVApiManager]
class DefaultCVApiManager implements CVApiManager {
  final String _TAG = 'DefaultCVClient';

  ClientApiInterceptor apiInterceptor;

  DefaultCVApiManager({
    @required this.apiBaseUrl,
    @required this.apiInterceptor,
  })  : assert(apiBaseUrl != null),
        assert(apiInterceptor != null) {
    _dio = Dio(Options(
      baseUrl: apiBaseUrl,
      connectTimeout: 3000,
      contentType: ContentType.json,
      responseType: ResponseType.JSON,
    ));

    /// Add Interceptor
    _dio.interceptor.response.onSuccess = apiInterceptor.onSuccess;
  }

  // TODO : Add Interceptor for token
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

  ///
  /// OAuth
  ///
  @override
  Future<OAuthAccessTokenResponseModel> fetchToken({
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:fetchToken');

    OAuthTokenModel oauthModel = OAuthTokenModel(
      username: email,
      password: password,
    );

    _dio.interceptor.request.onSend =
        apiInterceptor.onRequestAccessTokenWithClientAndUserCredentials;

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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    Response response = await _dio.get(_pathMe);

    return ResponseModel<UserDataModel>.fromJson(response.data);
  }

  @override
  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromAccount');

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    String _path = _pathMe + _pathProfiles;

    Response response = await _dio.get(
      _path,
      data: {
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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    String _path = _pathProfiles;

    Response response = await _dio.get(_path, data: {
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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    String _path = _pathProfiles + '/$profileId' + _pathParts;

    Response response = await _dio.get(_path, data: {
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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    Response response =
        await _dio.get(_pathParts + '/$partId' + _pathGroups, data: {
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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

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

    _dio.interceptor.request.onSend = apiInterceptor.onSendWithAccessToken;

    String _path = _pathGroups + '/$groupId' + _pathEntries;

    Response response = await _dio.get(_path, data: {
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
