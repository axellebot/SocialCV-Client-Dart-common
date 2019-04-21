import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/events/account_event.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';
import 'package:social_cv_client_dart_common/src/states/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final String _TAG = 'AccountBloc';

  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;

  AccountBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
  })  : assert(cvRepository != null),
        assert(preferencesRepository != null),
        super();

  @override
  AccountState get initialState => AccountUninitialized();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    print('$_TAG:mapEventToState($event)');

    if (event is AccountRefresh) {
      try {
        UserDataModel userModel = await cvRepository.fetchAccount();
        await preferencesRepository.setUserId(userModel.id);
      } catch (error) {
        yield AccountFailed(error: error);
      }
    }
  }
}
