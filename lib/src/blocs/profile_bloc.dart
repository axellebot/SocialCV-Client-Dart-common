import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Profile Fetch
class ProfileBloc extends BlocBase {
  final String _TAG = "ProfileBloc";

  ProfileBloc({
    @required this.cvRepository,
  })  : assert(cvRepository != null),
        super() {
    _isFetchingProfileController.add(false);
  }

  final CVRepository cvRepository;

  // Reactive variables
  final _isFetchingProfileController = BehaviorSubject<bool>();
  final _profileController = BehaviorSubject<ProfileDataModel>();

  // Streams
  Observable<bool> get isFetchingProfileStream =>
      _isFetchingProfileController.stream;

  Observable<ProfileDataModel> get profileStream => _profileController.stream;

  Future<void> fetchProfileDetails(String profileId) async {
    print('$_TAG:fetchProfileDetails');
    if (!_isFetchingProfileController.value) {
      _isFetchingProfileController.add(true);

      await cvRepository
          .fetchProfile(profileId)
          .then(_profileController.add)
          .catchError(_profileController.addError);

      _isFetchingProfileController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingProfileController.close();
    _profileController.close();
  }
}
