import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/config/values.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Group List Fetch
class GroupListBloc extends BlocBase {
  final String _TAG = "GroupListBloc";

  GroupListBloc({
    @required this.cvRepository,
  })  : assert(cvRepository != null),
        super() {
    _isFetchingGroupsController.add(false);
    _groupPerPage.add(kCVItemsPerPageDefault);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingGroupsController = BehaviorSubject<bool>();
  final _profileGroupsController = BehaviorSubject<List<GroupDataModel>>();
  final _groupPerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingGroupsStream =>
      _isFetchingGroupsController.stream;

  Observable<List<GroupDataModel>> get groupsStream =>
      _profileGroupsController.stream;

  Observable<String> get groupPerPage => _groupPerPage.stream;

  // Human functions
  Future<void> setItemsPerPage(String partPerPage) async {
    _groupPerPage.add(partPerPage);
  }

  Future<void> fetchPartGroups(String partId) async {
    print('$_TAG:fetchPartGroups');
    if (!_isFetchingGroupsController.value) {
      _isFetchingGroupsController.add(true);

      await cvRepository
          .fetchPartGroups(partId: partId)
          .then(_profileGroupsController.add)
          .catchError(_profileGroupsController.addError);

      _isFetchingGroupsController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingGroupsController.close();
    _profileGroupsController.close();
    _groupPerPage.close();
  }
}
