import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/group_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

const String _TAG = "GroupBloc";

/// Business Logic Component for Group Fetch
class GroupBloc extends BlocBase {
  GroupBloc({
    this.cvRepository,
  })
      : assert(cvRepository != null),
        super() {
    _isFetchingGroupController.add(false);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingGroupController = BehaviorSubject<bool>();
  final _groupController = BehaviorSubject<GroupModel>();

  // Streams
  Observable<bool> get isFetchingGroupStream =>
      _isFetchingGroupController.stream;

  Observable<GroupModel> get groupStream => _groupController.stream;

  void fetchGroup(String groupId) async {
    print('$_TAG:fetchGroup');
    if (!_isFetchingGroupController.value) {
      _isFetchingGroupController.add(true);

      await cvRepository
          .fetchGroup(groupId)
          .then(_groupController.add)
          .catchError(_groupController.addError);

      _isFetchingGroupController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingGroupController.close();
    _groupController.close();
  }
}
