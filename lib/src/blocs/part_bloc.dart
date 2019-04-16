import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

const String _TAG = "PartBloc";

/// Business Logic Component for Profile Part Fetch
class PartBloc extends BlocBase {
  PartBloc({
    this.cvRepository,
  })
      : assert(cvRepository != null),
        super() {
    _isFetchingPartController.add(false);
  }

  final CVRepositoryImpl cvRepository;

  // Reactive variables
  final _isFetchingPartController = BehaviorSubject<bool>();
  final _partController = BehaviorSubject<PartDataModel>();

  // Streams
  Observable<bool> get isFetchingPartStream => _isFetchingPartController.stream;

  Observable<PartDataModel> get partStream => _partController.stream;

  void fetchPart(String partId) async {
    print('$_TAG:fetchPart');
    if (!_isFetchingPartController.value) {
      _isFetchingPartController.add(true);

      await cvRepository
          .fetchPart(partId)
          .then(_partController.add)
          .catchError(_partController.addError);

      _isFetchingPartController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingPartController.close();
    _partController.close();
  }
}
