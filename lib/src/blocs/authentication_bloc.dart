import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/blocs/account_bloc.dart';
import 'package:social_cv_client_dart_common/src/events/account_event.dart';
import 'package:social_cv_client_dart_common/src/events/authentication_event.dart';
import 'package:social_cv_client_dart_common/src/repositories/config_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Authentication
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String _TAG = 'AuthBloc';

  AuthenticationBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
    @required this.secretRepository,
    @required this.accountBloc,
  })  : assert(preferencesRepository != null),
        assert(cvRepository != null),
        assert(secretRepository != null),
        super();

  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;
  final ConfigRepository secretRepository;
  final AccountBloc accountBloc;

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    if (event is AppStarted) {
      final String token = await preferencesRepository.getAccessToken();

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
  }
}
