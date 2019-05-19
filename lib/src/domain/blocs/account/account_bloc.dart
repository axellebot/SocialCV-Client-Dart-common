import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for Account
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final String _tag = '$AccountBloc';

  final CVRepository cvRepository;
  final AppPreferencesRepository appPreferencesRepository;

  AccountBloc({
    @required this.cvRepository,
    @required this.appPreferencesRepository,
  })  : assert(
          cvRepository != null,
          'No $CVRepository given',
        ),
        assert(
          appPreferencesRepository != null,
          'No $AppPreferencesRepository given',
        ),
        super();

  @override
  AccountState get initialState => AccountUninitialized();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    print('$_tag:$mapEventToState($event)');

    if (event is AccountRefresh) {
      yield* _mapAccountRefreshToState(event);
    }
  }

  /// Map [AccountRefresh] to [AccountState]
  ///
  /// ```dart
  /// yield* _mapAccountRefreshToState(event);
  /// ```
  Stream<AccountState> _mapAccountRefreshToState(AccountRefresh event) async* {
    try {
      yield AccountLoading();
      final userModel = await cvRepository.fetchAccount();
      await appPreferencesRepository.setUserId(userModel.id);
      yield AccountLoaded(user: userModel);
    } catch (error) {
      print('$_tag:$_mapAccountRefreshToState -> ${error.runtimeType}');
      yield AccountFailed(error: error);
    }
  }
}
