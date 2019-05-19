import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for Registration
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final String _tag = '$RegisterBloc';

  final CVRepository cvRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({@required this.cvRepository, @required this.authenticationBloc})
      : assert(cvRepository != null, 'No $CVRepository given'),
        assert(authenticationBloc != null, 'No $AuthenticationBloc given'),
        super();

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    print('$_tag:$mapEventToState($event)');

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
