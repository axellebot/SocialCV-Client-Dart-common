import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  AppStarted() : super([]);

  @override
  String toString() => '$AppStarted';
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
      '$LoggedIn { accessToken: $accessToken, accessTokenExpirationDate: $accessTokenExpirationDate, refreshToken: $refreshToken, refreshTokenExpirationDate: $refreshTokenExpirationDate }';
}

class LoggedOut extends AuthenticationEvent {
  LoggedOut() : super([]);

  @override
  String toString() => '$LoggedOut {}';
}
