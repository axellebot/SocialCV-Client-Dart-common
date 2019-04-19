import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/config/values.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';

/// Business Logic Component for Profile List Fetch
class ProfileListBloc extends BlocBase {
  final String _TAG = "ProfileListBloc";

  ProfileListBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
  })  : assert(cvRepository != null),
        assert(preferencesRepository != null),
        super() {
    _isFetchingProfilesController.add(false);
    _profilePerPage.add(kCVItemsPerPageDefault);
  }

  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;

  // Reactive variables
  final _isFetchingProfilesController = BehaviorSubject<bool>();
  final _profilesController = BehaviorSubject<List<ProfileDataModel>>();
  final _profilePerPage = BehaviorSubject<String>();

  // Streams
  Observable<bool> get isFetchingProfilesStream =>
      _isFetchingProfilesController.stream;

  Observable<List<ProfileDataModel>> get profilesStream =>
      _profilesController.stream;

  Observable<String> get profilePerPage => _profilePerPage.stream;

  // Human functions
  Future<void> setItemsPerPage(String partPerPage) async {
    _profilePerPage.add(partPerPage);
  }

  Future<void> fetchAccountProfiles() async {
    print('$_TAG:fetchAccountProfiles');
    if (!_isFetchingProfilesController.value) {
      _isFetchingProfilesController.add(true);

      await cvRepository
          .fetchAccountProfiles()
          .then(_profilesController.add)
          .catchError(_profilesController.addError);

      _isFetchingProfilesController.add(false);
    }
  }

  Future<void> fetchProfiles(String profileTitle) async {
    print("$_TAG:fetchProfiles->$profileTitle");
    if (!_isFetchingProfilesController.value) {
      _isFetchingProfilesController.add(true);

      String accessToken = await preferencesRepository.getAccessToken();

      await cvRepository
          .fetchProfiles(profileTitle: profileTitle)
          .then(_profilesController.add)
          .catchError(_profilesController.addError);

      _isFetchingProfilesController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingProfilesController.close();
    _profilesController.close();
    _profilePerPage.close();
  }
}
