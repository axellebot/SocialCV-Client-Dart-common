import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for Authentication
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String _TAG = '$AuthenticationBloc';

  final CVRepository cvRepository;
  final AuthPreferencesRepository authPreferencesRepository;
  final ConfigRepository configRepository;
  final AccountBloc accountBloc;

  AuthenticationBloc({
    @required this.cvRepository,
    @required this.authPreferencesRepository,
    @required this.configRepository,
    @required this.accountBloc,
  })
      : assert(
  cvRepository != null,
  'No $CVRepository given',
  ),
        assert(
        authPreferencesRepository != null,
        'No $AppPreferencesRepository given',
        ),
        assert(
        configRepository != null,
        'No $ConfigRepository given',
        ),
        assert(
        accountBloc != null,
        'No $AccountBloc given',
        ),
        super();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print('$_TAG:$mapEventToState($event)');
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  /// Map [AppStarted] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapAppStartedToState(event);
  /// ```
  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    try {
      final token = await authPreferencesRepository.getAccessToken();

      /// TODO: Check access token expiration and fetch new access token with refresh token
      /// TODO: Check refresh token expiration, if it's expired set state to Unauthenticated

      if (token != null && token?.length > 0) {
        yield AuthenticationAuthenticated();
        accountBloc.dispatch(AccountRefresh());
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (error) {
      yield AuthenticationFailed(error: error);
    }
  }

  /// Map [LoggedIn] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapLoggedInToState(event);
  /// ```
  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthenticationLoading();
    await authPreferencesRepository.setAccessToken(event.accessToken);
    await authPreferencesRepository
        .setAccessTokenExpiration(event.accessTokenExpirationDate);
    await authPreferencesRepository.setRefreshToken(event.refreshToken);
    await authPreferencesRepository
        .setRefreshTokenExpiration(event.refreshTokenExpirationDate);
    yield AuthenticationAuthenticated();
    accountBloc.dispatch(AccountRefresh());
  }

  /// Map [LoggedIn] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapLoggedInToState(event);
  /// ```
  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    yield AuthenticationLoading();
    await authPreferencesRepository.deleteAccessToken();
    await authPreferencesRepository.deleteAccessTokenExpiration();
    await authPreferencesRepository.deleteRefreshToken();
    await authPreferencesRepository.deleteRefreshTokenExpiration();
    yield AuthenticationUnauthenticated();
  }
}
