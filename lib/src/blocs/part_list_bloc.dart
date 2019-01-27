import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/config/values.dart';
import 'package:social_cv_client_dart_common/src/models/part_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';

const String _TAG = "PartListBloc";

/// Business Logic Component for Part List Fetch
class PartListBloc extends BlocBase {
  PartListBloc({
    this.cvRepository,
    this.preferencesRepository,
  })
      : assert(cvRepository != null),
        assert(preferencesRepository != null),
        super() {
    _isFetchingPartsController.add(false);
    _partPerPage.add(kCVItemsPerPageDefault);
  }

  final CVRepository cvRepository;
  final PreferencesRepositoryI preferencesRepository;

  // Reactive variables
  final _isFetchingPartsController = BehaviorSubject<bool>();
  final _partsController = BehaviorSubject<List<PartModel>>();
  final _partPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingPartsStream =>
      _isFetchingPartsController.stream;

  Observable<List<PartModel>> get partsStream => _partsController.stream;

  Observable<String> get partPerPage => _partPerPage.stream;

  // Human functions
  void setItemsPerPage(String partPerPage) async {
    _partPerPage.add(partPerPage);
  }

  void fetchProfileParts(String profileId) async {
    print('$_TAG:fetchProfileParts');
    if (!_isFetchingPartsController.value) {
      _isFetchingPartsController.add(true);

      String accessToken = await preferencesRepository.getAccessToken();

      await cvRepository
          .fetchProfileParts(profileId: profileId)
          .then(_partsController.add)
          .catchError(_partsController.addError);

      _isFetchingPartsController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingPartsController.close();
    _partsController.close();
    _partPerPage.close();
  }
}
