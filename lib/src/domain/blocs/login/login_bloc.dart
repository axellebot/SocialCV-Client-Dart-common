import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _tag = '$LoginBloc';

  final CVRepository cvRepository;
  final AuthenticationBloc authBloc;

  LoginBloc({
    @required this.cvRepository,
    @required this.authBloc,
  })  : assert(cvRepository != null, 'Missing CV Repository'),
        assert(authBloc != null, 'Missing Authentication Bloc'),
        super();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is LoginButtonPressed) {
        yield LoginLoading();

        final AccessTokenViewModelModel response =
            await cvRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authBloc.dispatch(LoggedIn(
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
