import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for Authentication
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String _TAG = 'AuthenticationBloc';

  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;
  final ConfigRepository secretRepository;
  final AccountBloc accountBloc;

  AuthenticationBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
    @required this.secretRepository,
    @required this.accountBloc,
  })  : assert(
            preferencesRepository != null, 'No preferences repository given'),
        assert(cvRepository != null, 'No CV repository given'),
        assert(secretRepository != null, 'No secret repository given'),
        super();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is AppStarted) {
        final String token = await preferencesRepository.getAccessToken();

        /// TODO: Check access token expiration and fetch new access token with refresh token
        /// TODO: Check refresh token expiration, if it's expired set state to Unauthenticated

        if (token != null) {
          yield AuthenticationAuthenticated();
          accountBloc.dispatch(AccountRefresh());
        } else {
          yield AuthenticationUnauthenticated();
        }
      }

      if (event is LoggedIn) {
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

      if (event is LoggedOut) {
        yield AuthenticationLoading();
        await preferencesRepository.deleteAccessToken();
        await preferencesRepository.deleteAccessTokenExpiration();
        await preferencesRepository.deleteRefreshToken();
        await preferencesRepository.deleteRefreshTokenExpiration();
        yield AuthenticationUnauthenticated();
      }
    } catch (error) {
      yield AuthenticationFailed(error: error);
    }
  }
}
