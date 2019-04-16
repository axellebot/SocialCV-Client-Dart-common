import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_cv_client_dart_common/src/errors/api_errors.dart';
import 'package:social_cv_client_dart_common/src/errors/base_errors.dart';
import 'package:social_cv_client_dart_common/src/errors/http_errors.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

const String _TAG = "CVClient";

abstract class CVClient {
  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> fetchToken({
    OAuthTokenModel oauthTokenModel,
  });

  ///
  /// Account
  ///

  Future<ResponseModel<UserDataModel>> fetchAccount();

  Future<ResponseModelWithArray<ProfileDataModel>> fetchAccountProfiles({
    int offset,
    int limit,
  });

  ///
  /// Profiles
  ///

  Future<ResponseModel<ProfileDataModel>> fetchProfile(
    String profileId,
  );

  Future<ResponseModelWithArray<PartDataModel>> fetchProfileParts({
    String profileId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Parts
  ///

  Future<ResponseModel<PartDataModel>> fetchPart(
    String partId,
  );

  Future<ResponseModelWithArray<GroupDataModel>> fetchPartGroups({
    String partId,
    int offset,
    int limit,
  });

  ///
  /// Groups
  ///

  Future<ResponseModel<GroupDataModel>> fetchGroup(
    String groupId,
  );

  Future<ResponseModelWithArray<EntryDataModel>> fetchGroupEntries({
    String groupId,
    int offset,
    int limit,
  });

  ///
  /// Entries
  ///

  Future<ResponseModel<EntryDataModel>> fetchEntry(
    String entryId,
  );

  ///
  /// Profiles
  ///

  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset,
    int limit,
  });
}

/// Default Implementation of [CVClient]
class CVClientImpl extends CVClient {
  CVClientImpl({
    this.accessToken,
    this.refreshToken,
  });

  String accessToken;
  String refreshToken;

  static final Dio client = Dio(Options(
    baseUrl: _apiBaseUrl,
    connectTimeout: 3000,
    responseType: ResponseType.JSON,
  ));

  static final String _apiBaseUrl = "https://api.cv.lebot.me";

  static final String _pathOauth = "/oauth";
  static final String _pathOauthToken = _pathOauth + "/token";

  static final String _pathMe = "/me";
  static final String _pathProfiles = "/profiles";
  static final String _pathParts = "/parts";
  static final String _pathGroups = "/groups";
  static final String _pathEntries = "/entries";

  static final String _pathMeProfiles = _pathMe + _pathProfiles;

  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> fetchToken({
    OAuthTokenModel oauthTokenModel,
  }) async {
    assert(oauthTokenModel != null);

    return client
        .post(
      _pathOauthToken,
      options: Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
      ),
      data: oauthTokenModel.toJson(),
    )
        .then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPasswordError();
        case HttpStatus.notFound:
          throw ApiErrorUserNotFoundError();
      }
      final OAuthAccessTokenResponseModel model =
          OAuthAccessTokenResponseModel.fromJson(response.data);
      this.accessToken = model.accessToken;
      this.refreshToken = model.refreshToken;
      return model;
    });
  }

  ///
  /// Account
  ///

  Future<ResponseModel<UserDataModel>> fetchAccount() async {
    print("$_TAG:fetchAccountDetails");
    return client
        .get(
      _pathMe,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<UserDataModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<ProfileDataModel>> fetchAccountProfiles({
    int offset = 0,
    int limit = 5,
  }) async {
    return client
        .get(
      _pathMeProfiles,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.notFound:
          throw BaseError("Profiles from account not found");
      }
      return ResponseModelWithArray<ProfileDataModel>.fromJson(response.data);
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModel<ProfileDataModel>> fetchProfile(
    String profileId,
  ) async {
    return client
        .get(
      _pathProfiles + "/$profileId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<ProfileDataModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<PartDataModel>> fetchProfileParts({
    String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    Uri uri = Uri.https(
      _apiBaseUrl,
      _pathProfiles + "/$profileId" + _pathParts,
      {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order"
      },
    );

    return client
        .get(
      _pathProfiles + "/$profileId" + _pathParts,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order"
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModelWithArray<PartDataModel>.fromJson(response.data);
    });
  }

  ///
  /// Parts
  ///

  Future<ResponseModel<PartDataModel>> fetchPart(
    String partId,
  ) async {
    return client
        .get(
      _pathParts + "/$partId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<PartDataModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<GroupDataModel>> fetchPartGroups({
    String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    return client
        .get(
      _pathParts + "/$partId" + _pathGroups,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order",
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((response) {
      return ResponseModelWithArray<GroupDataModel>.fromJson(response.data);
    });
  }

  ///
  /// Groups
  ///

  Future<ResponseModel<GroupDataModel>> fetchGroup(
    String groupId,
  ) async {
    return client
        .get(
      _pathGroups + "/$groupId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((response) {
      return ResponseModel<GroupDataModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<EntryDataModel>> fetchGroupEntries({
    String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    return client.get(
      _pathGroups + "/$groupId" + _pathEntries,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order",
      },
    ).then((response) {
      return ResponseModelWithArray<EntryDataModel>.fromJson(response.data);
    });
  }

  ///
  /// Entries
  ///

  Future<ResponseModel<EntryDataModel>> fetchEntry(
    String entryId,
  ) async {
    return client
        .get(
      _pathEntries + "/$entryId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<EntryDataModel>.fromJson(response.data);
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 10,
  }) async {
    return client.get(
      _pathProfiles,
      options: Options(
        baseUrl: _apiBaseUrl,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: {
        "title": profileTitle,
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
    ).then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPaginationError();
        case HttpStatus.notFound:
          throw ApiErrorProfileNotFoundError();
      }
      return ResponseModelWithArray<ProfileDataModel>.fromJson(response.data);
    });
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
