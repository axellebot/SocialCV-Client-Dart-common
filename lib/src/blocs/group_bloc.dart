import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Group Fetch
class GroupBloc extends BlocBase {
  final String _TAG = "GroupBloc";

  GroupBloc({
    @required this.cvRepository,
  })  : assert(cvRepository != null),
        super() {
    _isFetchingGroupController.add(false);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingGroupController = BehaviorSubject<bool>();
  final _groupController = BehaviorSubject<GroupDataModel>();

  // Streams
  Observable<bool> get isFetchingGroupStream =>
      _isFetchingGroupController.stream;

  Observable<GroupDataModel> get groupStream => _groupController.stream;

  Future<void> fetchGroup(String groupId) async {
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
