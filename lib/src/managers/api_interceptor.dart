import 'dart:io';

import 'package:dio/dio.dart';

class ClientApiInterceptor {
  String clientId;
  String clientSecret;
  String accessToken;
  String refreshToken;

  ClientApiInterceptor({
    this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
  });

  InterceptorCallback get onRequestAccessTokenWithClientAndUserCredentials =>
      (Options options) {
        options.contentType =
            ContentType.parse('application/x-www-form-urlencoded');
        if (clientId != null && clientSecret != null) {
          options.data.addAll({
            'client_id': '$clientId',
            'client_secret': '$clientSecret',
            'grant_type': 'password',
          });
        }
        return options;
      };

  InterceptorCallback get onSendWithAccessToken => (Options options) {
        if (accessToken != null) {
          options.headers
              .addAll({HttpHeaders.authorizationHeader: 'Bearer $accessToken'});
        }
        return options;
      };

  InterceptorCallback get onRequestAccessTokenWithRefreshToken =>
      (Options options) {
        if (refreshToken != null) {
          options.data.addAll({'refresh_token': '$refreshToken'});
        }
        return options;
      };

  InterceptorsSuccessCallback get onSuccess => (Response response) {
        if (response.data['access_token']) {
          accessToken = response.data['access_token'];
        }
        if (response.data['refresh_token']) {
          refreshToken = response.data['refresh_token'];
        }
        return response;
      };
}
