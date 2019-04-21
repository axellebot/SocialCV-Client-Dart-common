import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/blocs/authentication_bloc.dart';
import 'package:social_cv_client_dart_common/src/events/authentication_event.dart';
import 'package:social_cv_client_dart_common/src/events/login_event.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _TAG = 'LoginBloc';

  LoginBloc({
    @required this.cvRepository,
    @required this.authBloc,
  }) : super();

  final CVRepository cvRepository;

  final AuthenticationBloc authBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is LoginButtonPressed) {
        yield LoginLoading();

        final OAuthAccessTokenResponseModel response =
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
