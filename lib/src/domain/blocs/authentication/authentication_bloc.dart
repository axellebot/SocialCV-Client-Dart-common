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
  final PreferencesRepository preferencesRepository;
  final ConfigRepository configRepository;
  final AccountBloc accountBloc;

  AuthenticationBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
    @required this.configRepository,
    @required this.accountBloc,
  })  : assert(
          cvRepository != null,
          'No $CVRepository given',
        ),
        assert(
          preferencesRepository != null,
          'No $PreferencesRepository given',
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
      final String token = await preferencesRepository.getAccessToken();

      /// TODO: Check access token expiration and fetch new access token with refresh token
      /// TODO: Check refresh token expiration, if it's expired set state to Unauthenticated

      if (token != null) {
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
    await preferencesRepository.setAccessToken(event.accessToken);
    await preferencesRepository
        .setAccessTokenExpiration(event.accessTokenExpirationDate);
    await preferencesRepository.setRefreshToken(event.refreshToken);
    await preferencesRepository
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
    await preferencesRepository.deleteAccessToken();
    await preferencesRepository.deleteAccessTokenExpiration();
    await preferencesRepository.deleteRefreshToken();
    await preferencesRepository.deleteRefreshTokenExpiration();
    yield AuthenticationUnauthenticated();
  }
}
