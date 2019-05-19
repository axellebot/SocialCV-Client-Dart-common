import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// [AuthenticationEvent] that must be dispatch to [AuthenticationBloc]
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);

  String toString() => '$runtimeType{}';
}

/// Use [AppStarted] to begin auth process on startup
class AppStarted extends AuthenticationEvent {}

/// Use [LoggedIn] to inform that user just logged in
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

/// Use [LoggedOut] to request logout
class LoggedOut extends AuthenticationEvent {}
