import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/config/values.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Entry List Fetch
class EntryListBloc extends BlocBase {
  final String _TAG = "EntryListBloc";

  EntryListBloc({
    @required this.cvRepository,
  })  : assert(cvRepository != null),
        super() {
    _isFetchingEntriesController.add(false);
    _entryPerPage.add(kCVItemsPerPageDefault);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingEntriesController = BehaviorSubject<bool>();
  final _entriesController = BehaviorSubject<List<EntryDataModel>>();
  final _entryPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingGroupEntriesStream =>
      _isFetchingEntriesController.stream;

  Observable<List<EntryDataModel>> get entriesStream =>
      _entriesController.stream;

  Observable<String> get entryPerPage => _entryPerPage.stream;

  // Human functions
  Future<void> setItemsPerPage(String partPerPage) async {
    _entryPerPage.add(partPerPage);
  }

  Future<void> fetchGroupEntries(String groupId) async {
    print('$_TAG:fetchGroupEntries');
    if (!_isFetchingEntriesController.value) {
      _isFetchingEntriesController.add(true);

      await cvRepository
          .fetchGroupEntries(
            groupId: groupId,
          )
          .then(_entriesController.add)
          .catchError(_entriesController.addError);

      _isFetchingEntriesController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingEntriesController.close();
    _entriesController.close();
    _entryPerPage.close();
  }
}
