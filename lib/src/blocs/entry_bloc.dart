import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Entry Fetch
class EntryBloc extends BlocBase {
  final String _TAG = "EntryBloc";

  EntryBloc({
    @required this.cvRepository,
  })  : assert(cvRepository != null),
        super() {
    _isFetchingEntryController.add(false);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingEntryController = BehaviorSubject<bool>();
  final _entryController = BehaviorSubject<EntryDataModel>();

  // Streams
  Observable<bool> get isFetchingEntryStream =>
      _isFetchingEntryController.stream;

  Observable<EntryDataModel> get entryStream => _entryController.stream;

  Future<void> fetchEntry(String profileEntryId) async {
    print('$_TAG:fetchEntry');
    if (!_isFetchingEntryController.value) {
      _isFetchingEntryController.add(true);

      await cvRepository
          .fetchEntry(profileEntryId)
          .then(_entryController.add)
          .catchError(_entryController.addError);

      _isFetchingEntryController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingEntryController.close();
    _entryController.close();
  }
}
