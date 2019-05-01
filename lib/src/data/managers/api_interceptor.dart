import 'dart:io';

import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  String _clientId;
  String _clientSecret;
  String _accessToken;
  String _refreshToken;

  InterceptorsWrapper _interceptorWrapper;

  ApiInterceptor({
    String clientId,
    String clientSecret,
    String accessToken,
    String refreshToken,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    _interceptorWrapper =
        InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse);
  }

  InterceptorsWrapper get interceptorsWrapper => _interceptorWrapper;

  RequestOptions _onRequest(RequestOptions options) {
    /// Adding client credentials
    if (_clientId != null && _clientSecret != null) {
      options.headers.addAll({
        'client_id': '$_clientId',
        'client_secret': '$_clientSecret',
        'grant_type': 'password',
      });
    }

    /// Addind access token
    if (_accessToken != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: 'Bearer $_accessToken'});
    }

    /// Adding refresh token
    if (_refreshToken != null) {
      options.headers.addAll({'refresh_token': '$_refreshToken'});
    }

    return options;
  }

  Response<dynamic> _onResponse(Response<dynamic> response) {
    /// Save access token
    if (response.data['access_token']) {
      _accessToken = response.data['access_token'];
    }

    /// Save refresh token
    if (response.data['refresh_token']) {
      _refreshToken = response.data['refresh_token'];
    }

    return response;
  }
}
