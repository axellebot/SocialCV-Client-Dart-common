import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/entry_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

const String _TAG = "EntryBloc";

/// Business Logic Component for Entry Fetch
class EntryBloc extends BlocBase {
  EntryBloc({
    this.cvRepository,
  })
      : assert(cvRepository != null),
        super() {
    _isFetchingEntryController.add(false);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingEntryController = BehaviorSubject<bool>();
  final _entryController = BehaviorSubject<EntryModel>();

  // Streams
  Observable<bool> get isFetchingEntryStream =>
      _isFetchingEntryController.stream;

  Observable<EntryModel> get entryStream => _entryController.stream;

  void fetchEntry(String profileEntryId) async {
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
