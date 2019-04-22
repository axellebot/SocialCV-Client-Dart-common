import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_dart_common/src/blocs/authentication_bloc.dart';
import 'package:social_cv_client_dart_common/src/events/register_event.dart';
import 'package:social_cv_client_dart_common/src/states/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final String _TAG = 'RegisterBloc';

  final AuthenticationBloc authenticationBloc;

  RegisterBloc({this.authenticationBloc});

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    print('$_TAG:mapEventToState($event)');

    try {
      if (event is RegisterButtonPressed) {
        yield RegisterLoading();
        await Future.delayed(Duration(seconds: 2));
        yield RegisterInitial();
      }
    } catch (error) {
      yield RegisterFailure(error: error);
    }
  }
}
