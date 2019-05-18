import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final String _tag = '$AccountBloc';

  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;

  AccountBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
  })  : assert(
          cvRepository != null,
          'No $CVRepository given',
        ),
        assert(
          preferencesRepository != null,
          'No $PreferencesRepository given',
        ),
        super();

  @override
  AccountState get initialState => AccountUninitialized();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    print('$_tag:$mapEventToState($event)');

    if (event is AccountRefresh) {
      try {
        final userModel = await cvRepository.fetchAccount();
        await preferencesRepository.setUserId(userModel.id);
      } catch (error) {
        yield AccountFailed(error: error);
      }
    }
  }
}
