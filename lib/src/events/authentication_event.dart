import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

export 'package:social_cv_client_dart_common/src/states/authentication_state.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  AppStarted() : super();

  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String accessToken;
  final int accessTokenExpirationDate;
  final String refreshToken;
  final int refreshTokenExpirationDate;

  LoggedIn({
    @required this.accessToken,
    @required this.accessTokenExpirationDate,
    @required this.refreshToken,
    @required this.refreshTokenExpirationDate,
  }) : super([
          accessToken,
          accessTokenExpirationDate,
          refreshToken,
          refreshTokenExpirationDate
        ]);

  @override
  String toString() =>
      'LoggedIn { accessToken: $accessToken, accessTokenExpirationDate: $accessTokenExpirationDate, refreshToken: $refreshToken, refreshTokenExpirationDate: $refreshTokenExpirationDate }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
