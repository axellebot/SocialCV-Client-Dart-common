import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for Login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _tag = '$LoginBloc';

  final CVRepository cvRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.cvRepository,
    @required this.authenticationBloc,
  })  : assert(cvRepository != null, 'No $CVRepository given'),
        assert(authenticationBloc != null, 'No $AuthenticationBloc given'),
        super();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  /// Map [LoginButtonPressed] to [LoginState]
  ///
  /// ```dart
  /// yield* _mapLoginButtonPressedToState(event);
  /// ```
  Stream<LoginState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    try {
      if (event is LoginButtonPressed) {
        yield LoginLoading();

        final response = await cvRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(
          accessToken: response.accessToken,
          accessTokenExpirationDate: response.accessTokenExpiresAt,
          refreshToken: response.refreshToken,
          refreshTokenExpirationDate: response.accessTokenExpiresAt,
        ));

        yield LoginInitial();
      }
    } catch (error) {
      yield LoginFailure(error: error);
    }
  }
}
