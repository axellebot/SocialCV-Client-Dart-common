import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);

  String toString() => '$runtimeType{}';
}

class AppStarted extends AuthenticationEvent {}

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
      '$runtimeType{ accessToken: $accessToken, accessTokenExpirationDate: $accessTokenExpirationDate, refreshToken: $refreshToken, refreshTokenExpirationDate: $refreshTokenExpirationDate }';
}

class LoggedOut extends AuthenticationEvent {}
