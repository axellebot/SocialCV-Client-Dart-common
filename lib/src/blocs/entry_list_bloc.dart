import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/config/values.dart';
import 'package:social_cv_client_dart_common/src/models/entry_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

const String _TAG = "EntryListBloc";

/// Business Logic Component for Entry List Fetch
class EntryListBloc extends BlocBase {
  EntryListBloc({
    this.cvRepository,
  })
      : assert(cvRepository != null),
        super() {
    _isFetchingEntriesController.add(false);
    _entryPerPage.add(kCVItemsPerPageDefault);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingEntriesController = BehaviorSubject<bool>();
  final _entriesController = BehaviorSubject<List<EntryModel>>();
  final _entryPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingGroupEntriesStream =>
      _isFetchingEntriesController.stream;

  Observable<List<EntryModel>> get entriesStream => _entriesController.stream;

  Observable<String> get entryPerPage => _entryPerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _entryPerPage.add(partPerPage);
  }

  void fetchGroupEntries(String groupId) async {
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
